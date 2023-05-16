import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/data/app_text.dart';

class ContactPage extends StatefulWidget {
  final bool withIcons;

  final String destinationEmail;

  final bool hasHeading;

  /// [ContactPage] has 2 [required] fields [withIcons] and [destinationEmail].
  const ContactPage({
    Key? key,
    this.hasHeading = true,
    required this.withIcons,
    required this.destinationEmail,
  }) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _messageEditingController =
      TextEditingController();

  String name = '';

  String email = '';

  String message = '';

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _messageEditingController.dispose();
    super.dispose();
  }

  String? _validateName(String name) {
    // Regular Expression for fullname (a space between first name and second name)
    String nameRegExp = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";

    if (name.isEmpty) {
      // Name field should not be empty
      return 'Enter your name';
    }
    if (!RegExp(nameRegExp).hasMatch(name)) {
      return 'Give a space between \nyour first name and last name';
    }
    return null;
  }

  String? _validateEmail(String email) {
    // Regular Expression for email
    String emailRegExp =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (email.isEmpty) {
      // Name field should not be empty
      return 'Enter your email';
    }
    if (!RegExp(emailRegExp).hasMatch(email)) {
      // If the value in email field doesn't match with the regular expression
      // then it throws an error message.
      return 'Enter correctly.\nexample: username@example.com';
    }
    return null;
  }

  String? _validateMessage(String name) {
    if (name.isEmpty) {
      // Message field should not be empty
      return 'Message is empty. Please fill it.';
    }
    return null;
  }

  /// [_sendEmail] redirects to gmail app with the message and name
  /// entered by the user.
  void _sendEmail(
      {required String destEmail, required String body, required String name}) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    /// [emailLaunchUri] sends an email to the destination email.
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: destEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Feedback from $name',
        'body': body,
      }),
    );

    // Launching the URL.
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 32,
            bottom: 32,
          ),
          children: [
            _closeButton(),
            _headerMessage(),
            _buildForm(),
          ]),
    );
  }

  Widget _closeButton() {
    return Row(
      children: [
        const SizedBox(),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                width: 1.0,
              ),
            ),
            child: const Text(
              'Close',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Padding _headerMessage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        color: Colors.lightBlueAccent,
        child: Text(
          AppText.instance.getText(Tk.contact),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  /// Contact Form
  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 32,
            bottom: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.hasHeading
                  ? const Text(
                      'Contact Form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    )
                  : Container(),

              const SizedBox(
                height: 32,
              ),
              // Name Field
              TextFormField(
                controller: _nameEditingController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateName(value!),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    name = value!;
                  });
                },
                decoration: InputDecoration(
                  icon: widget.withIcons
                      ? const Icon(Icons.person_outline)
                      : null,
                  label: const Text('Name'),
                  hintText: 'FirstName LastName',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 32,
              ),

              // Email Field
              TextFormField(
                controller: _emailEditingController,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateEmail(value!),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
                decoration: InputDecoration(
                  icon: widget.withIcons
                      ? const Icon(Icons.alternate_email)
                      : null,
                  label: const Text('E-mail'),
                  hintText: 'Name',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 32,
              ),

              // Message or Feedback Field
              TextFormField(
                controller: _messageEditingController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateMessage(value!),
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    message = value!;
                  });
                },
                decoration: InputDecoration(
                  icon: widget.withIcons
                      ? const Icon(Icons.message_outlined)
                      : null,
                  label: const Text('Message'),
                  hintText: 'Message',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 32,
              ),

              // Submit button
              Row(
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.0,
                        ),
                      ),
                      child: const Text(
                        'submit',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            _sendEmail(
                              name: name,
                              destEmail: widget.destinationEmail,
                              body: message,
                            );

                            Navigator.pop(context);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
