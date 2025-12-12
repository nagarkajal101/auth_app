import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controller/auth_controller.dart';
import 'package:task03/view/auth/header.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///header
              AuthHeader(text: 'Login Page'),
              SizedBox(height: height * 0.02),

              ///Email_id
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),

              ///spacing
              SizedBox(height: height * 0.02),

              ///Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

              ///spacing
              SizedBox(height: height * 0.04),

              Obx(
                () => authController.isLoading.value
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: height * 0.06,
                        width: width * 0.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            authController.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: width * 0.04),
                          ),
                        ),
                      ),
              ),

              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: width * 0.035),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: width * 0.04),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
