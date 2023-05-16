/*
an enum with all possible text keys
*/

import 'package:website/data/app_data.dart';

enum Tk {
  slogan,
  contact;
}

/*
this class contains all text in different languages
*/
class TextItem {
  final String lang;
  final Tk key;
  final String text;

  TextItem(this.lang, this.key, this.text);
}

class AppText {
  static final List<TextItem> _allTextItems = [];

  AppText._() {
    _initialize();
  }

  static final instance = AppText._();

  String getText(Tk tk) {
    String lang = AppData.instance.language;
    return _allTextItems.firstWhere((e) => e.lang == lang && e.key == tk).text;
  }

  //---------------
  void _initialize() {
    //---------
    _add('nl', Tk.slogan,
        'Zonnebloem-software is jouw partner voor non-profit organisaties, om samen prachtige apps for zowel mobiel als web te bouwen.');
    _add('en', Tk.slogan,
        'Zonnebloem-software is your partner for non-profit organisations, for building beautiful apps for both both mobile and web.');

    //---------
    _add('nl', Tk.contact, '''
  
  Just send an email to:
  zonnebloem.software@gmail.com
  or use the contact form below
  ''');
    _add('en', Tk.contact, '''  
  
  Just send an email to:
  zonnebloem.software@gmail.com
  or use the contact form below
  ''');
  }

  void _add(String lang, Tk tk, String text) {
    _allTextItems.add(TextItem(lang, tk, text));
  }
}
