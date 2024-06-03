import 'package:flutter/material.dart';
import '../resources/app_color/color.dart';

class AppTextStyles {
  static TextStyle textStyleRoboto700 =  TextStyle(
      fontSize: 16,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w700,
      color: AppColor.blackColor
  );
  static TextStyle textStyleRoboto400 =  TextStyle(
      fontSize: 16,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      color: AppColor.blackColor
  );


}

extension TextStyleExtension on TextStyle {
  TextStyle get fontWeight500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get fontWeight400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get fontWeight800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get fontWeight700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get fontWeightBold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get fontSize18 => copyWith(fontSize: 18);
  TextStyle get fontSize14 => copyWith(fontSize: 14);
  TextStyle get fontSize12 => copyWith(fontSize: 12);


  TextStyle get decorationUnderline => copyWith(decoration: TextDecoration.underline);
  TextStyle get decorationLineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle setColor(Color color) => copyWith(color: color);
  TextStyle setFontSize(double fontSize) => copyWith(fontSize: fontSize);
}