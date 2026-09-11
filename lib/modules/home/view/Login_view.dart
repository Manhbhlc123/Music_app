import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:sq_mp3/modules/home/controller/Login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF8E50A4)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "login.title".tr(),
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Jaini',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Ô nhập Email ---
                  TextField(
                    controller: controller.emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFB17FD7),
                      filled: true,
                      labelText: "login.email".tr(),
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Ô nhập Password ---
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: controller.isVisibility.value,
                      decoration: InputDecoration(
                        fillColor: const Color(0xFFB17FD7),
                        filled: true,
                        labelText: "login.password".tr(),
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white70,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.togglePassword();
                          },
                          icon: Icon(
                            controller.isVisibility.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- Nút Đăng Nhập ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      return ElevatedButton(
                        onPressed: controller.handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF8E50A4),
                        ),
                        child: Text(
                          "login.login_button".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),

                  // --- Hàng Checkbox Remember Me & Forgot Password ---
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.isRemember.value,
                          onChanged: controller.toggleRemember,
                          side: const BorderSide(color: Colors.white),
                        ),
                      ),
                      Text(
                        "login.remember_me".tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement Forgot Password logic
                          Get.snackbar(
                            "Info",
                            "Forgot password feature coming soon",
                          );
                        },
                        child: Text(
                          "login.forgot_password".tr(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // --- Hàng Chuyển sang Đăng ký ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "login.no_account".tr(),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: controller.goToSignup,
                        child: Text(
                          "login.signup".tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
