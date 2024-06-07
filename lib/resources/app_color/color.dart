import 'package:flutter/material.dart';

class AppColor {

  static Color scaffoldColor = 0xffF8F8F8.color;
  static Color blackColor = 0xff363636.color;
  static Color textBlackColor = 0xff000000.color;
  static Color whiteColor = 0xffFFFFFF.color;
  static Color productCardShadowColor = 0xff4D5877.color;
  static Color regularPriceColor = 0xff989FA8.color;
  static Color emptyRatingColor = 0xffD3D8E5.color;
  static Color ratingColor = 0xffF5A623.color;
  static Color horizontalContainerShadow = 0xff395AB8.color;
  static Color filterIconColor = 0xffB6BED4.color;
  static Color filterTextColor = 0xff818995.color;
  static Color signInUpIconColor = 0xff7C8592.color;
  static Color signInUpLabelTextColor = 0xffA4A9AF.color;
  static Color signInUpButtonColor = 0xffF75F55.color;
  static Color facebookColor = 0xff3B5998.color;
  static Color createAccountColor = 0xff383C40.color;
  static Color loginTextColor = 0xff2893E3.color;
  static Color cameraBgColor1 = 0xffF2709C.color;
  static Color cameraBgColor2 = 0xffFF9472.color;
  static Color cameraShadowColor = 0xff8B2F40.color;
  static Color personIconColor = 0xff7C8592.color;
  static Color bottomSheetBgColor = 0xffF8F8F8.color;
  static Color checkBoxColor = 0xffFF708A.color;
  static Color bottomSheetApplyBtnColor = 0xff1ABC9C.color;
  static Color bottomNavItemColor = 0xff6E7FAA.color;
  static Color navActiveIconColor = 0xffFF679B.color;

  //account page
  static Color accountPageTextColor = 0xff263238.color;


}

extension on int{
  Color get color  => Color(this);
}