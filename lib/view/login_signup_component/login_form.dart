import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controllers/auth_controller.dart';
import 'package:task03/controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final authController = Get.find<AuthController>();

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///Email_id
        Obx(
          () => TextField(
            controller: loginController.emailController,
            decoration: InputDecoration(
              errorText: loginController.emailError.value,
              prefixIcon: const Icon(Icons.mail),
              labelText: 'Email',
              border: const OutlineInputBorder(),
            ),
          ),
        ),

        ///spacing
        SizedBox(height: height * 0.02),

        ///Password
        Obx(
          () => TextField(
            controller: loginController.passController,
            obscureText: loginController.isPassHidden.value,
            decoration: InputDecoration(
              errorText: loginController.passwordError.value,
              suffixIcon: IconButton(
                icon: Icon(
                  loginController.isPassHidden.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () => loginController.isPassHidden.toggle(),
              ),
              prefixIcon: const Icon(Icons.password),
              labelText: 'Password',
              border: const OutlineInputBorder(),
            ),
          ),
        ),

        ///spacing
        SizedBox(height: height * 0.04),

        Obx(
          () => loginController.isLoading.value
              ? const CircularProgressIndicator()
              : SizedBox(
                  height: height * 0.06,
                  width: width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await loginController.loginAction();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: width * 0.04),
                    ),
                  ),
                ),
        ),

        // -------Dont have an Account--------
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
              child: Text('Sign Up', style: TextStyle(fontSize: width * 0.04)),
            ),
          ],
        ),
      ],
    );
  }
}
