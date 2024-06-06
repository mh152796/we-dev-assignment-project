import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_dev_assignment_project/data/network/network_api_services.dart';
import 'package:we_dev_assignment_project/resources/api_routes/api_routes.dart';
import 'package:we_dev_assignment_project/resources/app_string/app_string.dart';
import 'package:we_dev_assignment_project/routes/routes_name.dart';
import 'package:we_dev_assignment_project/utils/custom_message.dart';

import '../../../data/response/status.dart';

class AuthController extends GetxController{
  final SharedPreferences sharedPreferences;
  final _api = NetworkApiServices();
  RxBool isLogIn = false.obs;
  final loginRequestStatus = Status.ERROR.obs;
  final registrationRequestStatus = Status.ERROR.obs;

  final formKey = GlobalKey<FormState>();


  void setRxLoginRequestStatus(Status value) => loginRequestStatus.value = value;
  void setRxRegistrationRequestStatus(Status value) => registrationRequestStatus.value = value;

  String? validateName(String? name) {
    if (userNameController.text.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if(emailController.text.isEmpty){
      return 'Email is required!';
    }
    else if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? pass) {
    if (passwordController.text.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late TextEditingController emailController;
  late TextEditingController streetAddressController;
  late TextEditingController aptSuiteController;
  late TextEditingController zipCodeController;

  String fullName = "";
  String email = "";
  String streetAddress = "";
  String aptSuite = "";
  String zipCode = "";


  AuthController({required this.sharedPreferences}){
    isLogIn.value = sharedPreferences.getBool(AppString.isLogIn) ?? false;
  }

  @override
  void onInit() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    repeatPasswordController = TextEditingController();
    streetAddressController = TextEditingController();
    aptSuiteController = TextEditingController();
    zipCodeController = TextEditingController();
    super.onInit();
  }

   @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    zipCodeController.dispose();
    emailController.dispose();
    aptSuiteController.dispose();
    repeatPasswordController.dispose();
    streetAddressController.dispose();
    super.onClose();
  }

  Future<void> userRegistration() async{

      if (!formKey.currentState!.validate()) {
        return;
      }

    setRxRegistrationRequestStatus(Status.LOADING);
    await _api.postApi(url: ApiRoutes.signUpUrl, data: {
      {
        "username": userNameController.text,
        "email": emailController.text,
        "password": passwordController.text
      }
    }).then((value){
      if(value["code"] == 200){

        userLogin();

      }
      else {
        setRxRegistrationRequestStatus(Status.ERROR);
      }
    },).onError((error, stackTrace) {
      setRxRegistrationRequestStatus(Status.ERROR);
    },);
  }

  Future<void> userLogin() async{
    if (!formKey.currentState!.validate()) {
      return;
    }
    setRxLoginRequestStatus(Status.LOADING);
    await _api.postApi(url: ApiRoutes.signInUrl, data:
      {
        "username": emailController.text,
        "password": passwordController.text
      }
    ).then((value){
       email = value["user_email"];
       fullName = value["user_nicename"];
       email = value["user_email"];
       isLogIn.value = true;
       CustomMessage().showToast(message: "Success");
        sharedPreferences.setBool(AppString.isLogIn, true);
       setRxRegistrationRequestStatus(Status.COMPLETED);
        setRxLoginRequestStatus(Status.COMPLETED);
        Get.offAllNamed(RoutesName.bottomNavScreen);
    },).onError((error, stackTrace) {
      setRxRegistrationRequestStatus(Status.ERROR);
    },);
  }
  
}