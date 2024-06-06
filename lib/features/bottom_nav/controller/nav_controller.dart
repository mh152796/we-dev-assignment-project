import 'package:get/get.dart';

class NavController extends GetxController{

  RxInt navIndex = 0.obs;


  void updateNavIndex({required int index}){
    navIndex.value = index;
  }

}