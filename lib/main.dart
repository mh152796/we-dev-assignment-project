import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/home/controller/product_controller.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/resources/app_string/app_string.dart';
import 'package:we_dev_assignment_project/routes/routes.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';

import 'core/initial_binding/initial_binding.dart';

void main() {

   initBinding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.signInPage,
       getPages: AppRoutes.appRoutes(),
       theme: ThemeData(
        scaffoldBackgroundColor: AppColor.scaffoldColor,
         fontFamily: "Roboto",
         useMaterial3: true,
      ),
     );
  }
}

