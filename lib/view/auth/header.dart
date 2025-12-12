import "package:flutter/material.dart";

class AuthHeader extends StatelessWidget {
  AuthHeader({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: height * 0.02),

          Image.asset(
            'assets/images/authentication.png',
            height: height * 0.2,
            width: width * 0.5,
            fit: BoxFit.contain,
          ),
          SizedBox(height: height * 0.02),
          Text(
            text,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }
}
