import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controller/auth_controller.dart';

class SignUpController extends GetxController {
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
  final isPassHidden = true.obs;
  final isConfPassHidden = true.obs;

  /// initially gender value is null(DropDown)
  final gender = ''.obs;

  ///Date of birth initially null
  final selectedDOB = Rxn<DateTime>();

  ///-------------------************************-------------------------

  //Error-variables
  final nameError = RxnString();
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
    nameError.value = null;
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

    //Name validation
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty) {
      nameError.value = 'Required name';
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

    //Email validation
    bool validateEmail(String email) {
      String pattern1 = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      return RegExp(pattern1).hasMatch(email);
    }

    if (!validateEmail(emailController.text) || emailController.text.isEmpty) {
      emailError.value = "Please Enter a valid Email ";
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

  //Signup action when button tappped
  void signUPAction() {
    if (!validateAndSubmit()) return;

    //Full name
    final fullName =
        '${firstNameController.text.trim()} ${lastNameController.text}';

    // For calculating age

    final birthDate = selectedDOB.value!;

    final personAge = DateTime.now().year - birthDate.year;

    //for signup functionality
    authController.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      userName: userNameController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      age: personAge,
      phoneNumber: phoneController.text.trim(),
      address: addressController.text.trim(),
      dob: selectedDOB.value!,
      fullName: fullName,
      gender: gender.value,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
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
