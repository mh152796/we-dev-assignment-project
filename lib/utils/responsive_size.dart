import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  double get sHeight => MediaQuery.of(this).size.height;
  double get sWidth => MediaQuery.of(this).size.width;

  double convertToResponsiveSize(int size) => (size / sWidth) * sWidth;
}