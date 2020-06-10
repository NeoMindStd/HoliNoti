import 'package:flutter/cupertino.dart';

class GlobalPage {
  static const TextStyle blockTitle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle blockContents = TextStyle(fontSize: 17);
  static const EdgeInsets blockMargin =
      EdgeInsets.only(left: 10, right: 10, top: 15);
  static const boxBorder = BorderRadius.all(Radius.circular(25));
}

class Colors {
  const Colors();

  // Global
  static const String STATUS_BAR = "#FF9551";
  static const String ACTION_BAR = "#F3753A";
  static const String ACTION_BAR_TITLE = "#FFFFFF";

  static const Color ORANGE = const Color(0xFFF3753A);
  static const Color WHITE = const Color(0xFFFFFFFF);
  static const Color ORANGE_LIGHT = const Color(0xFFFF9551);
  static const Color ORANGE_DARK = const Color(0xFFE26429);
  static const Color APRICOT = const Color(0xFFF9BA9D);
}
