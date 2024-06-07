import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/auth/controller/auth_controller.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';
import 'package:we_dev_assignment_project/utils/text_style.dart';

import '../../../custom_widget/custom_horizontal_container.dart';
import '../../../data/response/status.dart';
import '../../../utils/gaps.dart';
import '../widget/image_button.dart';
import '../widget/sign_in_up_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.verticalGapOf(50),
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
            Gaps.verticalGapOf(50),
            Form(
                key: _authController.formKeySignUp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildTextField(textEditingController: _authController.userNameController, labelText: 'Name', leadingIcon: Icons.person, textInputType: TextInputType.name, validator: _authController.validateName),
                    Gaps.verticalGapOf(15),
                    buildTextField(textEditingController: _authController.emailController, labelText: 'Email', leadingIcon: Icons.email_outlined, textInputType: TextInputType.visiblePassword, validator: _authController.validateEmail),

                    Gaps.verticalGapOf(15),
                    buildTextField(textEditingController: _authController.passwordController, labelText: 'Password', leadingIcon: Icons.lock_outline, textInputType: TextInputType.visiblePassword, validator: _authController.validatePassword),

                    Gaps.verticalGapOf(15),
                    buildTextField(textEditingController: _authController.repeatPasswordController, labelText: 'Password', leadingIcon: Icons.lock_outline, textInputType: TextInputType.visiblePassword, validator: _authController.validatePassword),
                  ],
                )),
            Gaps.verticalGapOf(50),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(() => SignInUpButton(
                    isLoading: _authController.registrationRequestStatus.value == Status.LOADING? true : false,
                    buttonText: "Sign Up", onPressed: () {
                      if(_authController.registrationRequestStatus.value == Status.LOADING){
                        return;
                      }
                    _authController.userRegistration();
                  },),),
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
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: RichText(
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
                ),
              ],
            ),
            Gaps.verticalGapOf(50)
          ],
        ),
      ),
    );
  }

  Widget buildTextField({required TextEditingController textEditingController, required String labelText, required IconData leadingIcon, double height = 55, TextInputType? textInputType, Widget? suffixIcon, String? Function(String?)? validator}) {
    return CustomHorizontalContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: TextFormField(
          controller: textEditingController,
          validator: validator,
          decoration: InputDecoration(
            // labelText: 'Email',
            hintText: labelText,
            prefixIcon: Icon(leadingIcon, color: AppColor.signInUpIconColor, size: 20,),
            suffixIcon: suffixIcon,
            errorStyle: const TextStyle(fontSize: 8, color: Colors.red, fontStyle: FontStyle.italic),
            errorBorder: InputBorder.none,
            labelStyle: TextStyle(color: AppColor.signInUpLabelTextColor),
            border: InputBorder.none, // Remove border
          ),
          // validator: _validateEmail,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ), );
  }
}
