import 'package:get/get.dart';
import 'package:task03/model/auth_model.dart';
import 'package:task03/service/auth_services.dart';

class AuthController extends GetxController {
  final AuthServices authService = AuthServices();

  final currentUser = Rxn<AuthModel>();

  ///Logged user - current user after login
  void setUser(AuthModel? loggedUser) {
    currentUser.value = loggedUser;
  }

  ///Logout
  void logOut() async {
    await authService.logout();
    Get.offAllNamed('/login');
  }
}
