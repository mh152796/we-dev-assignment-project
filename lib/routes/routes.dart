import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';

import '../features/auth/pages/account_screen.dart';
import '../features/auth/pages/sign_in_screen.dart';
import '../features/auth/pages/sign_up_screen.dart';
import '../features/bottom_nav/bottm_nav_screen.dart';
import '../features/home/pages/home_page.dart';

class AppRoutes {
  static appRoutes() => [

    RoutesName.homePage.toGetPage(page: () =>  HomePage()),
    RoutesName.signUpScreen.toGetPage(page: () =>  SignUpScreen()),
    RoutesName.signInPage.toGetPage(page: () =>  const SignInPage()),
    RoutesName.accountScreen.toGetPage(page: () =>  const AccountScreen()),
    RoutesName.bottomNavScreen.toGetPage(page: () =>  BottomNavScreen()),

  ];
}

extension GetPageExtension on String {
  GetPage toGetPage({required Widget Function() page, List<Bindings> bindings = const [], Bindings? binding,}) {
    return GetPage(
      name: this,
      page: page,
      binding: binding,
      bindings: bindings,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 800),
      transition: Transition.leftToRightWithFade,
    );
  }
}

