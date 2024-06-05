import 'package:flutter/material.dart';
import 'package:we_dev_assignment_project/features/home/pages/home_page.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/responsive_size.dart';

class BottomNavScreen extends StatelessWidget {
    BottomNavScreen({super.key});

  final List navWidgetList = [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.transparent,
        onPressed: () {

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
      body: navWidgetList[0],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(

        ),
        notchMargin: 10,
         child: SizedBox(
           height: 50,
            child: Row(
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

                       }, child: Icon(Icons.home_outlined, color: AppColor.bottomNavItemColor, size: 30,),
                     ),
                     MaterialButton(
                       minWidth: 50,
                       onPressed: () {

                     }, child: Icon(Icons.dashboard_outlined, color: AppColor.bottomNavItemColor, size: 30,),
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

                       }, child: Icon(Icons.shopping_cart_outlined, color: AppColor.bottomNavItemColor, size: 30,),
                     ),
                     MaterialButton(
                       minWidth: 50,
                       onPressed: () {

                       }, child: Icon(Icons.person_outline, color: AppColor.bottomNavItemColor, size: 30,),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         )
      ),
    );
  }
}
