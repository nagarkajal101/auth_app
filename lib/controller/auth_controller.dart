import 'package:get/get.dart';
import 'package:task03/model/auth_model.dart';
import 'package:task03/service/auth_services.dart';

class AuthController extends GetxController {
  final AuthServices _authService = AuthServices();

  var isLoading = false.obs;

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      // Call signup service
      AuthModel? newUser = await _authService.signup(email, password);

      if (newUser != null) {
        // user.value = newUser;
        Get.offAllNamed('/home');
        Get.snackbar('Account created', 'Signup successful');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      AuthModel? userExist = await _authService.login(email, password);

      if (userExist != null) {
        Get.snackbar('Success', 'Login successful');
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    } finally {
      isLoading.value = false;
    }
  }

  ///Logout
  void logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }
}
