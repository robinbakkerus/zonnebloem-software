import 'dart:developer';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';

class AppData {
  AppData._();

  static final instance = AppData._();

  String language = 'en';

  /// screen sizes, will be set
  double screenWidth = 400.0;
  double screenHeight = 500.0;

  ///---------
  bool isLandscape() {
    return screenWidth > screenHeight;
  }

  /// initially called to obtain screen sizes and locale
  void initialize(BuildContext context) {
    /// Full screen width and height
    screenWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    /// Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;

    /// Height (without status and toolbar)
    screenHeight = height - padding.top - kToolbarHeight;

    _getLanguage();
  }

  /// currently only english & dutch are supported
  void _getLanguage() {
    final String defaultLocale = Platform.localeName;
    log('local = $defaultLocale');
    final String lang = defaultLocale.substring(0, 2);
    final String countryCode = defaultLocale.substring(3, 5);
    log('lang = $lang country = $countryCode');
    if (lang == 'nl' || countryCode.toLowerCase() == 'nl') {
      language = 'nl';
    } else {
      language = 'en';
    }
  }
}
