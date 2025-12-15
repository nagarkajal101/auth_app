import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controller/auth_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome ${FirebaseAuth.instance.currentUser!.email} \nYou have successfully logged in.",
              ),
            ),

            SizedBox(height: 10),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.cyan,
                ),
                child: Text("Logout"),
                onPressed: () {
                  authController.logOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
