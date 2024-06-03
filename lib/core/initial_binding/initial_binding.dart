import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/home/controller/product_controller.dart';

void initBinding() {
  //this binding are used before called GetMaterial app
  Get.lazyPut(() => ProductController(), fenix: true);
}
