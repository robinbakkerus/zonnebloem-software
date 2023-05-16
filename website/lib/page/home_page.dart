import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:website/data/app_data.dart';
import 'package:website/data/app_text.dart';
import 'package:website/page/about_page.dart' as about_page;
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:website/page/contact_page.dart';

class ZonnebloemHomePage extends StatefulWidget {
  const ZonnebloemHomePage({super.key});

  @override
  State<ZonnebloemHomePage> createState() => _ZonnebloemHomePageState();
}

class _ZonnebloemHomePageState extends State<ZonnebloemHomePage>
    with TickerProviderStateMixin {
  //keeps track of logo image
  int _logoIndex = 0;
  late Timer _timer;
  final bool _isVisible = true;

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(microseconds: 500),
  //   vsync: this,
  // )..repeat(reverse: false);
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeIn,
  // );

  @override
  void initState() {
    _timer = Timer.periodic(
        const Duration(seconds: 3),
        (Timer timer) => setState(() {
              // _isVisible = !_isVisible;
              _logoIndex++;
              if (_logoIndex > 8) {
                _logoIndex = 0;
              }
            }));

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppData.instance.initialize(context);

    return Scaffold(
        appBar: _appBar(),
        body: ListView(
          // padding: const EdgeInsets.all(1),
          children: <Widget>[
            _logo(),
            // _liquidText(),
            _coloredText('''Zonnebloem Software'''),
            _slogan()
          ],
        ));
  }

  Container _logo() {
    return Container(
        height: _logoHeight(),
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.lightBlueAccent, width: 1)),
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceIn,
            opacity: _isVisible ? 1 : 0,
            child:
                Image(fit: BoxFit.fitHeight, image: AssetImage(_logoName()))));
  }

  Widget _slogan() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 2, 40, 10),
      height: AppData.instance.screenHeight - _logoHeight(),
      color: Colors.blue,
      child: Text(
        AppText.instance.getText(Tk.slogan),
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  String _logoName() {
    return 'assets/zonnebloemsoftware-logo$_logoIndex' '.jpg';
  }

  double _logoHeight() {
    if (AppData.instance.isLandscape()) {
      log('h = ${AppData.instance.screenHeight / 1.5}');
      return AppData.instance.screenHeight / 1.5;
    } else {
      log('H = ${AppData.instance.screenHeight / 1.5}');
      return AppData.instance.screenHeight / 2.0;
    }
  }

  // Widget _liquidText() {
  //   return TextLiquidFill(
  //     boxWidth: AppData.instance.screenWidth,
  //     text: 'Zonnebloem Software',
  //     textAlign: TextAlign.center,
  //     waveColor: Colors.amberAccent,
  //     boxBackgroundColor: Colors.blue,
  //     textStyle: const TextStyle(
  //       fontSize: 60.0,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     boxHeight: 150,
  //   );
  // }

  final _colorizeColors = [
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.red,
  ];

  final colorizeTextStyle = const TextStyle(
    fontSize: 60.0,
    fontFamily: 'Horizon',
  );

  Widget _coloredText(String txt) {
    return Container(
      color: Colors.blue,
      width: AppData.instance.screenWidth,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(txt,
                  textStyle: colorizeTextStyle,
                  colors: _colorizeColors,
                  textAlign: TextAlign.center),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Zonnebloem"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.contact_page),
          tooltip: 'Contact',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const ContactPage(
                    withIcons: true,
                    destinationEmail: 'zonnebloem.software@gmail.com');
              },
            ));
          },
        ), //IconButton
      ], //<Widget>[]
      backgroundColor: Colors.lightBlueAccent[100],
      elevation: 50.0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menu Icon',
        onPressed: () => _showAbout(),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ); //AppBar
  }

  _showAbout() {
    about_page.showAbout(context);
  }
}
