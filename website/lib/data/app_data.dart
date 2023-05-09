import 'package:flutter/material.dart';

class AppData {
  AppData._();

  static final instance = AppData._();

  /// screen sizes, will be set
  double screenWidth = 400.0;
  double screenHeight = 500.0;

  ///---------
  bool isLandscape() {
    return screenWidth > screenHeight;
  }

  /// initially called to obtain sizes
  void setScreenSizes(BuildContext context) {
    /// Full screen width and height
    screenWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    /// Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;

    /// Height (without status and toolbar)
    screenHeight = height - padding.top - kToolbarHeight;
  }
}
