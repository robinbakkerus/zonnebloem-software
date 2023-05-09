import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:website/data/app_data.dart';
import 'package:website/page/about_page.dart' as about_page;
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';

class ZonnebloemHomePage extends StatefulWidget {
  const ZonnebloemHomePage({super.key});

  @override
  State<ZonnebloemHomePage> createState() => _ZonnebloemHomePageState();
}

class _ZonnebloemHomePageState extends State<ZonnebloemHomePage> {
  final String _txt = '''
Zonnebloem-software is your partner for non-profit organisations, for building beautiful apps for both both mobile and web.
''';

  @override
  Widget build(BuildContext context) {
    AppData.instance.setScreenSizes(context);

    return Scaffold(
        appBar: _appBar(),
        body: ListView(
          // padding: const EdgeInsets.all(1),
          children: <Widget>[
            Container(
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    border:
                        Border.all(color: Colors.lightBlueAccent, width: 5)),
                child: const Image(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/zonnebloemsoftware-logo.jpg'))),
            _liquidText(),
            Container(
              padding: const EdgeInsets.fromLTRB(40, 2, 40, 10),
              height: AppData.instance.screenHeight - 350.0,
              color: Colors.blue,
              child: Text(
                _txt,
                style: const TextStyle(fontSize: 24),
              ),
            )
          ],
        ));
  }

  Widget _liquidText() {
    return TextLiquidFill(
      boxWidth: AppData.instance.screenWidth,
      text: 'Zonnebloem Software',
      textAlign: TextAlign.center,
      waveColor: Colors.amberAccent,
      boxBackgroundColor: Colors.blue,
      textStyle: const TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.bold,
      ),
      boxHeight: 150,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Zonnebloem"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.contact_page),
          tooltip: 'Comment Icon',
          onPressed: () {},
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
