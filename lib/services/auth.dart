import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  void signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("is_signIn");
    preferences.remove("email");

    Get.toNamed(
      '/sign-in',
    );
  }

  void endSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("is_signIn");
    preferences.remove("email");
  }
}
