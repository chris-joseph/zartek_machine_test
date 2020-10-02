import 'package:flutter/material.dart';

class Constants {
  static const String sample_text =
      'When a remote Python interpreter is added, at first the PyCharm helpers are copied to the remote host. \nPyCharm helpers are needed to run remotely the packaging tasks, debugger, tests and other PyCharm features. Next, the skeletons for binary libraries are generated and copied locally ';
  static const String sample_text2 =
      'When a remote Python interpreter is added, at first the PyCharm helpers are copied to the remote host. \nPyCharm helpers are needed to run remotely the packaging tasks, debugger, tests and other PyCharm features.';
  static const String sample_text3 =
      'When a remote Python interpreter is added, at first the PyCharm helpers are copied to the remote host.';

  static final rupeeSymbol = "\u20B9";

  static const String FEATURE_NOT_AVAILABLE = "Feature not available";

  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.green,
    Color(0xFFf0f0f0),
  ];

  static const primaryGreenColor = const Color(0xFF60D281);
  static const blackColor = const Color(0xFF000000);
  static const offWhiteColor = const Color(0x50FFFFFF);
  static const whiteColor = const Color(0xFFFFFFFF);
  static const tabIndicatorColor = const Color(0xFFD4D4D4);

  static const String SOME_ERROR_OCCURRED = "Some error occurred.";
}
