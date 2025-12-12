import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controller/auth_controller.dart';

class AuthForm extends StatelessWidget {
  AuthForm({super.key});

  final authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),

          ///spacing
          SizedBox(height: height * 0.02),

          ///Confirm Password
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: 'Confirm Password',
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
                        // Handle form submission
                        authController.signUp(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                      child: Text(
                        'Sign Up',
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
                'Already have an account?',
                style: TextStyle(fontSize: width * 0.035),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Text('Login', style: TextStyle(fontSize: width * 0.04)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
