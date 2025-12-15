import 'package:get/get.dart';
import 'package:task03/service/auth_services.dart';

class AuthController extends GetxController {
  final AuthServices authService = AuthServices();

  final isLoading = false.obs;

  ///SignUp function logic
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String userName,
    required String confirmPassword,
    required int age,
    required String gender,
    required String phoneNumber,
    required String address,
    required DateTime dob,
  }) async {
    try {
      isLoading.value = true;
      // Call signup service
      await authService.signup(
        email: email,
        password: password,
        userName: userName,
        confirmPassword: confirmPassword,
        age: age,
        phoneNumber: phoneNumber,
        address: address,
        dob: dob,
        gender: gender,
        fullName: fullName,
      );

      Get.snackbar(
        'Verify Email',
        'A verification link has been sent. Please verify to continue.',
      );

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///Login function logic
  Future<void> logIn(String email, String password) async {
    try {
      isLoading.value = true;
      await authService.login(email, password);

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///Logout
  void logOut() async {
    await authService.logout();
    Get.offAllNamed('/login');
  }
}
