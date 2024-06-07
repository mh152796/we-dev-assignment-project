import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    final _authController = Get.find<AuthController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.verticalGapOf(50),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                  width: 165,
                  height: 50,
                ),
              ),
            ),
            Gaps.verticalGapOf(50),
            Form(
              key: _authController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sign In", style: AppTextStyles.textStyleRoboto700.setFontSize(20),),
                  Gaps.verticalGapOf(20),
                  CustomHorizontalContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: _authController.emailController,
                        validator: _authController.validateEmail,
                        decoration: InputDecoration(
                          // labelText: 'Email',
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: AppColor.signInUpIconColor, size: 20,),
                          labelStyle: TextStyle(color: AppColor.signInUpLabelTextColor),
                          border: InputBorder.none, // Remove border
                        ),
                        // validator: _validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ), ),
                  Gaps.verticalGapOf(20),
                  CustomHorizontalContainer(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: _authController.passwordController,
                        validator: _authController.validatePassword,
                        decoration: InputDecoration(
                          // labelText: 'Email',
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline, color: AppColor.signInUpIconColor, size: 20,),
                          labelStyle: TextStyle(color: AppColor.signInUpLabelTextColor),
                          suffixIcon: Icon(Icons.remove_red_eye, color: AppColor.signInUpLabelTextColor.withOpacity(.78)),
                          border: InputBorder.none, // Remove border
                        ),
                        // validator: _validateEmail,
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ), ),
                  Gaps.verticalGapOf(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forgot Password?", textAlign: TextAlign.right, style: AppTextStyles.textStyleRoboto400.fontSize14.setColor(AppColor.signInUpLabelTextColor),)),
                  ),
                ],
              ),
            ),
            Gaps.verticalGapOf(60),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(() => SignInUpButton(
                    isLoading: _authController.loginRequestStatus.value == Status.LOADING? true : false,
                    buttonText: "Login", onPressed: () {
                    if(_authController.loginRequestStatus.value == Status.LOADING){
                      return;
                    }
                    _authController.userLogin();
                  },),),
                ),
                Gaps.verticalGapOf(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const ImageButton(imagePath: "facebook_logo.png", ),
                    Gaps.horizontalGapOf(10),
                    const ImageButton(imagePath: "google.png",),
                  ],
                ),

                Gaps.verticalGapOf(20),
                GestureDetector(
                  onTap: () {
                    _authController.clearController();
                    Get.toNamed(RoutesName.signUpScreen);
                  },
                  child: Text("Create New Account", style:
                  AppTextStyles.textStyleRoboto400.setColor(AppColor.createAccountColor).setFontSize(20),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
