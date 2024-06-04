import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';
import 'package:we_dev_assignment_project/utils/text_style.dart';

import '../../../custom_widget/custom_horizontal_container.dart';
import '../../../utils/gaps.dart';
import '../widget/image_button.dart';
import '../widget/sign_in_up_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.horizontalContainerShadow.withOpacity(.13),
                      offset: const Offset(3, 7),
                      blurRadius: 5,
                      spreadRadius: -6,
                    )
                  ]
                ),

                child: Icon(Icons.person_outline_outlined, color: AppColor.personIconColor, size: 36,),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    shape: BoxShape.circle,
                    gradient:  LinearGradient(colors: [
                      AppColor.cameraBgColor2,
                       AppColor.cameraBgColor1,
                    ],
                    begin: Alignment.topRight,
                      end: Alignment.bottomRight
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.cameraShadowColor.withOpacity(.13),
                        offset: const Offset(1, 5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  child: Icon(Icons.camera_alt, color: AppColor.whiteColor, size: 15,),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTextField(textEditingController: _nameController, labelText: 'Name', leadingIcon: Icons.person, textInputType: TextInputType.name),
              Gaps.verticalGapOf(15),
              buildTextField(textEditingController: _emailController, labelText: 'Email', leadingIcon: Icons.email_outlined, textInputType: TextInputType.visiblePassword),

            Gaps.verticalGapOf(15),
              buildTextField(textEditingController: _emailController, labelText: 'Password', leadingIcon: Icons.lock_outline, textInputType: TextInputType.visiblePassword),

            Gaps.verticalGapOf(15),
              buildTextField(textEditingController: _emailController, labelText: 'Password', leadingIcon: Icons.lock_outline, textInputType: TextInputType.visiblePassword),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SignInUpButton(
                  buttonText: "Sign Up", onPressed: () {
                Get.toNamed(RoutesName.signInPage);
                },),
              ),
              Gaps.verticalGapOf(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const ImageButton(imagePath: "facebook_logo.png",),
                  Gaps.horizontalGapOf(10),
                  const ImageButton(imagePath: "google.png",),
                ],
              ),
              Gaps.verticalGapOf(15),
              RichText(
                text:  TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account?",
                      style: AppTextStyles.textStyleRoboto400.setColor(AppColor.createAccountColor).setFontSize(20),
                    ),
                     TextSpan(
                      text: ' Login',
                      style: AppTextStyles.textStyleRoboto700.setColor(AppColor.loginTextColor).setFontSize(20),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField({required TextEditingController textEditingController, required String labelText, required IconData leadingIcon, double height = 55, TextInputType? textInputType, Widget? suffixIcon}) {
    return CustomHorizontalContainer(
              height: height,
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  // labelText: 'Email',
                  hintText: labelText,
                  prefixIcon: Icon(leadingIcon, color: AppColor.signInUpIconColor, size: 20,),
                  suffixIcon: suffixIcon,
                  labelStyle: TextStyle(color: AppColor.signInUpLabelTextColor),
                  border: InputBorder.none, // Remove border
                ),
                // validator: _validateEmail,
                keyboardType: textInputType,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ), );
  }
}
