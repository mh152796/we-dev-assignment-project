import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/auth/controller/auth_controller.dart';
import 'package:we_dev_assignment_project/features/auth/pages/account_screen.dart';
import 'package:we_dev_assignment_project/features/home/controller/product_controller.dart';
import 'package:we_dev_assignment_project/features/home/pages/home_page.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/responsive_size.dart';

import 'controller/nav_controller.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});
  final _navController = Get.find<NavController>();
  final List navWidgetList = [
    HomePage(),
    HomePage(),
    HomePage(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
          onPressed: () {
            Get.find<ProductController>().filterDialog(context: context);

          }, child: Container(
        height: 60,
        alignment: Alignment.center,
        width: 60,
        decoration:  BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xffB82D4825).withOpacity(.20),
                offset: const Offset(3, 7),
                blurRadius: 5,
                spreadRadius: -6,
              )
            ],
            gradient: const LinearGradient(colors:[
              Color(0xffFF679B),
              Color(0xffFF7B51)
            ])
        ),
        child:  Icon(Icons.search, color: AppColor.whiteColor,),
      )),
      body: Obx(() => navWidgetList[_navController.navIndex.value],),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(

          ),
          notchMargin: 10,
          child: SizedBox(
            height: 50,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.sWidth * .4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        minWidth: 50,
                        onPressed: () {
                          _navController.updateNavIndex(index: 0);
                        }, child: Icon(Icons.home_outlined, color: _navController.navIndex.value == 0? AppColor.navActiveIconColor : AppColor.bottomNavItemColor, size: 30,),
                      ),
                      MaterialButton(
                        minWidth: 50,
                        onPressed: () {
                          _navController.updateNavIndex(index: 1);
                        }, child: Icon(Icons.dashboard_outlined, color: _navController.navIndex.value == 1? AppColor.navActiveIconColor : AppColor.bottomNavItemColor, size: 30,),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: context.sWidth * .4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        minWidth: 50,
                        onPressed: () {
                          _navController.updateNavIndex(index: 2);
                        }, child: Icon(Icons.shopping_cart_outlined, color: _navController.navIndex.value == 2? AppColor.navActiveIconColor : AppColor.bottomNavItemColor, size: 30,),
                      ),
                      MaterialButton(
                        minWidth: 50,
                        onPressed: () {
                          Get.find<AuthController>().initializeUserController();
                          _navController.updateNavIndex(index: 3);
                        }, child: Icon(Icons.person_outline, color: _navController.navIndex.value == 3? AppColor.navActiveIconColor : AppColor.bottomNavItemColor, size: 30,),
                      ),
                    ],
                  ),
                ),
              ],
            ),),
          )
      ),
    );
  }
}
