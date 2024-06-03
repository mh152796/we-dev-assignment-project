import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';

import '../features/home/pages/home_page.dart';

class AppRoutes {
  static appRoutes() => [

    RoutesName.homePage.toGetPage(page: () =>  HomePage()),

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
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
    );
  }
}

