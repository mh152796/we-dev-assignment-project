import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [

    // RoutesName.webViewPayment.toGetPage(page: () =>   WebViewPayment(url: Get.arguments['url'], appbar: Get.arguments['appbar'], spOrderId: Get.arguments['spOrder'], routeName: Get.arguments['routeName'],)),
    // RoutesName.courseDetails.toGetPage(page: () =>  CourseDetails(course: Get.arguments['course'],)),

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

