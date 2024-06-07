import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
  RxString authToken = "".obs;
  final loginRequestStatus = Status.ERROR.obs;
  final registrationRequestStatus = Status.ERROR.obs;
  final updateUserRequestStatus = Status.ERROR.obs;

  Rx<Map?> user = Rx(null);

  final formKey = GlobalKey<FormState>();
  final formKeySignUp = GlobalKey<FormState>();
  final formKeyUserUpdate = GlobalKey<FormState>();


  void setRxLoginRequestStatus(Status value) => loginRequestStatus.value = value;
  void setRxRegistrationRequestStatus(Status value) => registrationRequestStatus.value = value;
  void setRxUpdateUserRequestStatus(Status value) => updateUserRequestStatus.value = value;

  String? validateName(String? name) {
    if (userNameController.text.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }
  String? validateFirstName(String? name) {
    if (firstNameController.text.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? validateLastName(String? name) {
    if (lastNameController.text.isEmpty) {
      return 'Please enter your last name';
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
  late TextEditingController nameController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late TextEditingController emailController;
  late TextEditingController streetAddressController;
  late TextEditingController aptSuiteController;
  late TextEditingController zipCodeController;

  AuthController({required this.sharedPreferences});


  void signOutUser(){
    user.value = null;
    authToken.value = "";
    isLogIn.value = false;
    clearController();
  }

  @override
  void onInit() {
    isLogIn.value = sharedPreferences.getBool(AppString.isLogIn) ?? false;
    authToken.value = sharedPreferences.getString(AppString.authToken) ?? "";
    if(sharedPreferences.getString(AppString.loggedUser) != null){
      Map? localUser = jsonDecode(sharedPreferences.getString(AppString.loggedUser)!);
      user.value = localUser;
    }

    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    repeatPasswordController = TextEditingController();
    streetAddressController = TextEditingController();
    aptSuiteController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    nameController = TextEditingController();
    zipCodeController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    userNameController.dispose();
    nameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    zipCodeController.dispose();
    emailController.dispose();
    aptSuiteController.dispose();
    repeatPasswordController.dispose();
    streetAddressController.dispose();
    super.onClose();
  }

  Future<void> userRegistration() async{

    if (!formKeySignUp.currentState!.validate()) {
      return;
    }

    setRxRegistrationRequestStatus(Status.LOADING);
    await _api.postApi(url: ApiRoutes.signUpUrl, data:
    {
      "username": userNameController.text,
      "email": emailController.text,
      "password": passwordController.text
    }
    ).then((value){
      print("valuevaluevaluevalue ${value}");
      if(value["code"] == 200){

        userLogin();

      }
      else {
        CustomMessage().showToast(message: "Failed");
        setRxRegistrationRequestStatus(Status.ERROR);
      }
    },).onError((error, stackTrace) {
      CustomMessage().showToast(message: "Failed");
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
      user(value);
      authToken.value = value["token"] ?? "";
      isLogIn.value = true;
      CustomMessage().showToast(message: "Success");
      sharedPreferences.setBool(AppString.isLogIn, true);
      sharedPreferences.setString(AppString.authToken, value["token"]??"");
      sharedPreferences.setString(AppString.loggedUser, jsonEncode(value));
      setRxRegistrationRequestStatus(Status.COMPLETED);
      setRxLoginRequestStatus(Status.COMPLETED);
      Get.offAllNamed(RoutesName.bottomNavScreen);
    },).onError((error, stackTrace) {
      CustomMessage().showToast(message: "Failed");
      setRxRegistrationRequestStatus(Status.ERROR);
    },);
  }

  Future<void> updateUser() async{
    if (!formKeyUserUpdate.currentState!.validate()) {
      return;
    }
    setRxUpdateUserRequestStatus(Status.LOADING);
    await _api.putApi(url: ApiRoutes.userUrl, data:
    {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "name": nameController.text,
    }
    ).then((value){
      user(value);
      isLogIn.value = true;
      sharedPreferences.setString(AppString.loggedUser, jsonEncode(value));
      CustomMessage().showToast(message: "Success");
      setRxUpdateUserRequestStatus(Status.COMPLETED);
    },).onError((error, stackTrace) {
      setRxUpdateUserRequestStatus(Status.ERROR);
    },);
  }

  void initializeUserController (){
    print("user.value?${user.value?["user_display_name"] }");
    nameController.text = user.value?["name"] ?? user.value?["user_display_name"] ?? "";
    firstNameController.text = user.value?["first_name"]??"";
    lastNameController.text = user.value?["last_name"]??"";
  }

  void clearController(){
    userNameController.text = "";
    nameController.text = "";
    firstNameController.text = "";
    lastNameController.text = "";
    passwordController.text = "";
    repeatPasswordController.text = "";
    emailController.text = "";
    streetAddressController.text = "";
    aptSuiteController.text = "";
    zipCodeController.text = "";
  }

  Future<void> signOut() async {
    signOutUser();
    sharedPreferences.clear();
    Get.offAllNamed(RoutesName.signInPage);
  }
}