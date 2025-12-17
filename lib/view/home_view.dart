import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task03/controllers/auth_controller.dart';

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
            Obx(() {
              final user = authController.currentUser.value;
              // if (user == null) {
              // return CircularProgressIndicator();
              // }

              final formattedDate = DateFormat(
                'dd MMMM yyyy',
              ).format(user!.dob);
              return Column(
                children: [
                  Text("Hello ${user.fullName} "),
                  Text('Your Date of Birth is $formattedDate'),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Welcome ${user.email} \nYou have successfully logged in.",
                    ),
                  ),
                ],
              );
            }),

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
