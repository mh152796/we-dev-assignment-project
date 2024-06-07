

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/resources/app_string/app_string.dart';
import 'package:we_dev_assignment_project/routes/routes.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';

import 'core/initial_binding/initial_binding.dart' as di;
import 'features/auth/controller/auth_controller.dart';
import 'features/home/controller/product_controller.dart';

Future<void> main() async {

  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized()
  );


  await di.initBinding();
  Get.find<AuthController>();
  Get.find<ProductController>();
  await Future.delayed(const Duration(seconds: 5));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: Get.find<AuthController>().isLogIn.value? RoutesName.bottomNavScreen : RoutesName.signInPage,
      getPages: AppRoutes.appRoutes(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.scaffoldColor,
        bottomSheetTheme: BottomSheetThemeData(
          surfaceTintColor: AppColor.bottomSheetBgColor, // Set your desired color here
        ),
        fontFamily: "Roboto",
        useMaterial3: true,
      ),
    );
  }
}

