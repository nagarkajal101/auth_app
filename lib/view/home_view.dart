import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task03/controller/auth_controller.dart';
import 'package:task03/service/auth_services.dart';

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
                "Welcome ${FirebaseAuth.instance.currentUser!.email} \nyou have successfully logged in.",
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  authController.logout();
                  Get.toNamed('/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
