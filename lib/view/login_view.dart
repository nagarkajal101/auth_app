import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controllers/auth_controller.dart';
import 'package:task03/view/auth/header.dart';
import 'package:task03/view/auth/login_form.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.1,
          ),
          child: Column(
            children: [
              ///header
              AuthHeader(text: 'Login Page'),

              SizedBox(height: height * 0.02),

              ///----Login Form----
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
