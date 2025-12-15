import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task03/controller/auth_controller.dart';
import 'package:task03/controller/sign_up_controller.dart';

class AuthForm extends StatelessWidget {
  AuthForm({super.key});

  final authController = Get.find<AuthController>();

  final signUpController = Get.put(SignUpController());

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
          Row(
            children: [
              ///First Name
              Expanded(
                child: Obx(
                  () => TextField(
                    controller: signUpController.firstNameController,
                    decoration: InputDecoration(
                      errorText: signUpController.nameError.value,
                      prefixIcon: Icon(Icons.person),
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.02),

              ///Last Name
              Expanded(
                child: Obx(
                  () => TextField(
                    controller: signUpController.lastNameController,
                    decoration: InputDecoration(
                      errorText: signUpController.nameError.value,
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),

          ///Username
          Obx(
            () => TextField(
              controller: signUpController.userNameController,
              decoration: InputDecoration(
                errorText: signUpController.userNameError.value,
                prefixIcon: Icon(Icons.person_pin),
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),

          ///Gender
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: signUpController.gender.value.isEmpty
                  ? null
                  : signUpController.gender.value,
              decoration: InputDecoration(
                labelText: 'Gender',
                errorText: signUpController.genderError.value,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (String? gvalue) {
                signUpController.gender.value = gvalue ?? '';
              },
            ),
          ),

          SizedBox(height: height * 0.02),

          ///Date of Birth
          Obx(
            () => TextField(
              readOnly: true,
              decoration: InputDecoration(
                errorText: signUpController.dobError.value,
                prefixIcon: Icon(Icons.calendar_today),
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(
                text: signUpController.selectedDOB.value == null
                    ? ''
                    : '${signUpController.selectedDOB.value!.day}-'
                          '${signUpController.selectedDOB.value!.month}-'
                          '${signUpController.selectedDOB.value!.year}',
              ),
              onTap: () async {
                final datePicked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                  initialDate: DateTime(2000),
                );
                if (datePicked != null) {
                  signUpController.selectedDOB.value = datePicked;
                }
              },
            ),
          ),

          SizedBox(height: height * 0.02),

          ///Address
          Obx(
            () => TextField(
              controller: signUpController.addressController,
              decoration: InputDecoration(
                errorText: signUpController.addressError.value,
                prefixIcon: Icon(Icons.home),
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),

          ///Phone Number
          Obx(
            () => TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              controller: signUpController.phoneController,
              decoration: InputDecoration(
                errorText: signUpController.phoneError.value,
                prefixIcon: Icon(Icons.call),
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),

          ///Email_id
          Obx(
            () => TextField(
              controller: signUpController.emailController,
              decoration: InputDecoration(
                errorText: signUpController.emailError.value,
                prefixIcon: Icon(Icons.mail),
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ///spacing
          SizedBox(height: height * 0.02),

          ///Password
          Obx(
            () => TextField(
              controller: signUpController.passwordController,
              obscureText: signUpController.isPassHidden.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    signUpController.isPassHidden.value
                        ? Icons.visibility_off_sharp
                        : Icons.visibility,
                  ),
                  onPressed: () => signUpController.isPassHidden.toggle(),
                ),
                errorText: signUpController.passwordError.value,
                prefixIcon: Icon(Icons.password),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ///spacing
          SizedBox(height: height * 0.02),

          ///Confirm Password
          Obx(
            () => TextField(
              controller: signUpController.confirmPasswordController,
              obscureText: signUpController.isConfPassHidden.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    signUpController.isConfPassHidden.value
                        ? Icons.visibility_off_sharp
                        : Icons.visibility,
                  ),
                  onPressed: () => signUpController.isConfPassHidden.toggle(),
                ),
                errorText: signUpController.confirmpassError.value,
                prefixIcon: Icon(Icons.password),
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ///spacing
          SizedBox(height: height * 0.04),

///------------Sign up button--------------
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
                        signUpController.signUPAction();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                    ),
                  ),
          ),

          SizedBox(height: height * 0.02),

///----------Already have an Account-----------------
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
