import 'package:flutter/material.dart';

class TestUtil {
  static Widget makeWidgetTestable(Widget testWidget) {
    return MaterialApp(home: testWidget);
  }
}
