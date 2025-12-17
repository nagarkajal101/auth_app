import 'package:flutter/material.dart';

import 'login_signup_component/header.dart';
import 'login_signup_component/signup_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
              ///Header
              AuthHeader(text: 'Sign up page'),

              SizedBox(height: height * 0.02),

              ///----SignUp Form----
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
