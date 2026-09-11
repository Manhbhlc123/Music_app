import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/provider/Auth_api_provider.dart';
import 'package:sq_mp3/core/services/Login_service.dart';
import 'package:sq_mp3/core/services/Token_service.dart';

class LoginController extends GetxController {
  final AuthApiProvide authApiProvide = AuthApiProvide();
  final LoginService loginService = LoginService();

  //quản lý UI
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final TokenService tokenService = TokenService();

  RxBool isVisibility = true.obs;
  var isRemember = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedData();
  }

  void login() {
    // Implementation for login logic
    isLoading.value = true;

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  void goToSignup() {
    Get.toNamed(Routes.signup);
  }

  Future<void> _loadSavedData() async {
    final value = await loginService.loadEmailRemember();
    emailController.text = value["EmailRemember"] ?? "";
    isRemember.value = value["rememberButtonState"] ?? false;
  }

  void toggleRemember(bool? value) {
    isRemember.value = value ?? false;
    loginService.saveRemenberButtonState(isRemember.value);
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng nhập đầy đủ thông tin",
          backgroundColor: Colors.white, colorText: Colors.black);
      return;
    }

    try {
      isLoading.value = true;
      final response = await authApiProvide.login(email, password);

      if (response.token.isNotEmpty) {
        await tokenService.saveToken(response.token);

        // Lưu hoặc xóa email tùy theo trạng thái Checkbox
        await loginService.saveEmailRemember(
            email: email,
            rememberButtonState: isRemember.value
        );

        // Chuyển sang màn hình Home (Dùng Get.offAll để xóa stack đăng nhập)
        Get.offAllNamed(Routes.home);
      } else {
        Get.snackbar("Thất bại", "login.loginFail".tr,
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString(),
          backgroundColor: Colors.white, colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }

  //toggle visible password func
  void togglePassword()
  {
    isVisibility.value = !isVisibility.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
