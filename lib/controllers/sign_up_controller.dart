import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controllers/auth_controller.dart';
import 'package:task03/service/auth_services.dart';

class SignUpController extends GetxController {
  final AuthServices _authService = AuthServices();
  final authController = Get.find<AuthController>();

  ///Text Controller variables
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();

  ///----Reactive variables----
  ///Loader
  final isLoading = false.obs;

  final isPassHidden = true.obs;
  final isConfPassHidden = true.obs;

  /// initially gender value is null(DropDown)
  final gender = ''.obs;

  ///Date of birth initially null
  final selectedDOB = Rxn<DateTime>();

  ///-------------------************************-------------------------

  //Error-variables
  final firstNameError = RxnString();
  final lastNameError = RxnString();
  final userNameError = RxnString();
  final dobError = RxnString();
  final genderError = RxnString();
  final emailError = RxnString();
  final phoneError = RxnString();
  final addressError = RxnString();
  final passwordError = RxnString();
  final confirmpassError = RxnString();

  /// Clear all errors
  void clearErrors() {
    firstNameError.value = null;
    lastNameError.value = null;
    userNameError.value = null;
    dobError.value = null;
    genderError.value = null;
    emailError.value = null;
    phoneError.value = null;
    addressError.value = null;
    passwordError.value = null;
    confirmpassError.value = null;
  }

  ///Validators
  bool validateAndSubmit() {
    clearErrors();
    bool isValid = true;

    //first Name validation
    if (firstNameController.text.trim().isEmpty) {
      firstNameError.value = 'Required';
      isValid = false;
    }
    if (lastNameController.text.trim().isEmpty) {
      lastNameError.value = 'Required';
      isValid = false;
    }

    //Username validation
    if (userNameController.text.isEmpty) {
      userNameError.value = 'Username is required';
      isValid = false;
    }

    //Dob validation
    if (selectedDOB.value == null) {
      dobError.value = 'Please enter Date Of Birth';
      isValid = false;
    }

    //Gender validation
    if (gender.value.isEmpty) {
      genderError.value = 'Please select your Gender';
      isValid = false;
    }

    //Address validation
    if (addressController.text.isEmpty) {
      addressError.value = 'Enter your address';
      isValid = false;
    }

    //Phone Number validation
    if (phoneController.text.length != 10) {
      phoneError.value = "Please enter a valid Phone number";
      isValid = false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = 'Invalid email';
      isValid = false;
    }

    //Password validation
    final passRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
    );
    if (!passRegex.hasMatch(passwordController.text)) {
      passwordError.value = 'Min 8 chars, upper, lower, number & symbol';
      isValid = false;
    }

    if (!isValid) return false;

    //confirm password validation
    if (passwordController.text != confirmPasswordController.text) {
      confirmpassError.value = "Confirm Password does not match";
      isValid = false;
    }

    return isValid;
  }

  ///claculating person age
  int calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;

    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  // //Signup action when button tappped
  ///signup
  Future<void> signupAction() async {
    if (!validateAndSubmit()) return;

    try {
      isLoading.value = true;

      final dob = selectedDOB.value!;
      final age = calculateAge(dob);

      await _authService.signup(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        userName: userNameController.text.trim(),
        fullName:
            '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        dob: dob,
        age: age,
        gender: gender.value,
        phoneNumber: phoneController.text.trim(),
        address: addressController.text.trim(),
      );

      Get.snackbar('Verify Email', 'Verification link sent to your email');

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Signup Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.onClose();
  }
}
