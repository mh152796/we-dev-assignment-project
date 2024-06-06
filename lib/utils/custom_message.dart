import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMessage{
  void showToast({
    required String message,
    Color color = Colors.green,
  }) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: color,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 2),
      message: message,
    ));
  }
}