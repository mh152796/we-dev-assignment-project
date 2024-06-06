import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_dev_assignment_project/features/home/controller/product_controller.dart';

import '../../features/auth/controller/auth_controller.dart';
import '../../features/bottom_nav/controller/nav_controller.dart';

Future<bool> initBinding() async {
  //this binding are used before called GetMaterial app
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ProductController(), fenix: true);
  Get.lazyPut(() => AuthController(sharedPreferences: Get.find()), fenix: true);
  Get.lazyPut(() => NavController(), fenix: true);
  return true;
}
