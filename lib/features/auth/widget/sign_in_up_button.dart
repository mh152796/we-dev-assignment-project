import 'package:flutter/material.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/responsive_size.dart';

import '../../../utils/text_style.dart';

class SignInUpButton extends StatelessWidget {
  const SignInUpButton({super.key, this.onPressed, required this.buttonText});

  final VoidCallback? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(context.sWidth , 50),
        backgroundColor: AppColor.signInUpButtonColor,
         foregroundColor: AppColor.signInUpButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
        onPressed: onPressed, child: Text(
      buttonText,
      style: AppTextStyles.textStyleRoboto400.fontWeight500.setColor(AppColor.whiteColor),
    ));
  }
}
