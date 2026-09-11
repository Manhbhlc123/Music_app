import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  //func save email when user click remember button
  Future<void> saveEmailRemember({
    required String email,
    required bool rememberButtonState,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (rememberButtonState) {
      await prefs.setBool("rememberButtonState", true);
      await prefs.setString("EmailRemember", email);
    } else {
      await prefs.remove("rememberButtonState");
      await prefs.remove("EmailRemember");
    }
  }

  //func load Email
  Future<Map<String, dynamic>> loadEmailRemember() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "EmailRemember": prefs.getString("EmailRemember") ?? "",
      "rememberButtonState": prefs.getBool("rememberButtonState") ?? false,
    };
  }


  //func save current state of checkButton
  Future<void> saveRemenberButtonState(bool state) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("rememberButtonState", state);
  }

  // func load state checkButton
  Future<bool> loadRememberButtonState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("rememberButtonState") ?? false;
  }
}