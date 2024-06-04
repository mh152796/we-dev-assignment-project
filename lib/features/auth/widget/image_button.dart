import 'package:flutter/material.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({super.key, required this.imagePath, this.size,});
 final  Size? size;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: IconButton.styleFrom(
          minimumSize: size ?? const Size(70, 70),
             elevation: 10,
             shadowColor: AppColor.horizontalContainerShadow.withOpacity(.13),
             backgroundColor: AppColor.whiteColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        onPressed: () {

    }, icon: Image.asset("assets/images/$imagePath"));
  }
}
