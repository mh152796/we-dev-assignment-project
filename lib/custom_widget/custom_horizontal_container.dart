import 'package:flutter/material.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';

class CustomHorizontalContainer extends StatelessWidget {
  const CustomHorizontalContainer({super.key, required this.child, this.height});

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 60 ,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColor.horizontalContainerShadow.withOpacity(.13),
            offset: const Offset(3, 7),
            blurRadius: 5,
            spreadRadius: -6,
          )
        ]
      ),
      child: child,
    );
  }
}
