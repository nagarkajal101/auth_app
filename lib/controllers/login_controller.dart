import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final authcontroller = Get.find<AuthController>();

  //Reactive variable
  final isPassHidden = true.obs;

  //Text Controller variables
  final emailController = TextEditingController();
  final passController = TextEditingController();

  /// Error messages
  final emailError = RxnString();
  final passwordError = RxnString();

  /// Clear errors
  void clearErrors() {
    emailError.value = null;
    passwordError.value = null;
  }

  bool validateAndLogin() {
    clearErrors();
    bool isValid = true;

    //Email validation
    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = 'Enter a valid Email';
      isValid = false;
    }

    return isValid;
  }

  ///------------Login Action---------------
  Future<void> loginAction() async {
    if (!validateAndLogin()) return;

    try {
      await authcontroller.logIn(
        emailController.text.trim(),
        passController.text.trim(),
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
