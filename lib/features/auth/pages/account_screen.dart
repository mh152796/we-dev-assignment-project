import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/text_style.dart';

import '../../../utils/gaps.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("My Account"),
        centerTitle: true,
        titleTextStyle: AppTextStyles.textStyleRoboto700.setFontSize(22),
      ),

      body: Column(
        children: [
          Column(
            children: [
              Gaps.verticalGapOf(30),
              Center(
                child: DottedBorder(
                  color: const Color(0xffFFADAD), // Set the border color
                  strokeCap: StrokeCap.round, // Ensure rounded dots
                  strokeWidth: 2.0, // Adjust the border width
                  dashPattern: const [5.0, 10.0],
                  borderType: BorderType.Circle, // Set circular border type
                  child: Container(
                  height: 130,
                    width: 130,
                    margin: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage("assets/images/man_img.png"), fit: BoxFit.fill)
                    ),
                  ),
                ),
              ),
              Gaps.verticalGapOf(30),
              Text("John Smith", style: AppTextStyles.textStyleRoboto700.setColor(AppColor.blackColor).setFontSize(24),),
              Text("info@johnsmith.com", style: AppTextStyles.textStyleRoboto400.setColor(const Color(0xff535353)).setFontSize(15),)
            ],
          ),
          Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
               boxShadow: [
                 BoxShadow(
                   color: const Color(0xff4D587721).withOpacity(.13),
                   offset: const Offset(3, 7),
                   blurRadius: 5,
                   spreadRadius: -6,
                 )
               ]
            ),
            child:   Column(
              children: [
             Row(
               children: [
                 const Icon(Icons.person_outline),
                 Text("Account", style: AppTextStyles.textStyleRoboto400.setColor(AppColor.blackColor).setFontSize(24),),
             Icon(Icons.arrow_forward_ios)
               ],
             )
              ],
            ),
          )
        ],
      ),
    );
  }
}
