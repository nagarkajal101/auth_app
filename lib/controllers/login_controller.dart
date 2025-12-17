import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controllers/auth_controller.dart';
import 'package:task03/model/auth_model.dart';
import 'package:task03/service/auth_services.dart';

class LoginController extends GetxController {
  final authController = Get.find<AuthController>();
  final AuthServices _authService = AuthServices();

  //Reactive variable
  final isLoading = false.obs;
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

    //validate password
    if (passController.text.trim().isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    }

    return isValid;
  }

  ///------------Login Action---------------

  Future<void> loginAction() async {
    if (!validateAndLogin()) return;

    try {
      isLoading.value = true;

      final AuthModel? user = await _authService.login(
        emailController.text.trim(),
        passController.text.trim(),
      );

      authController.setUser(user);

      ///Navigate to homeScrenafter success
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll("Ecxeption", " ").trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
