import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/Response/SignUpResponse.dart';
import 'package:sq_mp3/data/provider/Auth_api_provider.dart';
import 'package:sq_mp3/core/services/SignUp_service.dart';
import 'package:sq_mp3/core/storage/storage_service.dart';

class SignUpController extends GetxController {
  int? selectedYear;
  String? selectedCountry;
  var avatar_url = "".obs;
  String? language;

  final tenUser = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repassword = TextEditingController();
  final phone = TextEditingController();
  var isLoading = false.obs;

  final SignUpService signUpService = SignUpService();
  final AuthApiProvide authApiProvide = AuthApiProvide();
  SignUpResponse? signUpResponse;
  final StorageService storageService = StorageService();

  @override
  void onClose() {
    tenUser.dispose();
    email.dispose();
    password.dispose();
    repassword.dispose();
    phone.dispose();
    super.onClose();
  }

  void setSelectedYear(int year) {
    selectedYear = year;
    update();
  }

  void setSelectedCountry(String country) {
    selectedCountry = country;
    update();
  }

  void setLanguage(String lang) {
    language = lang;
    update();
  }

  void signUp() async {
    try {
      isLoading.value = true;

      var error = await signUpService.checkValidate(
        phone.text.trim(),
        email.text.trim(),
        password.text.trim(),
        repassword.text.trim(),
        selectedYear!,
        selectedCountry!,
        language!,
      );

      if (error != null) {
        Get.snackbar("Lỗi", error.toString());
      }

      signUpResponse = await authApiProvide.signUp(
        name: tenUser.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        phone: phone.text.trim(),
        birthYear: selectedYear!,
        country: selectedCountry!,
        language: language!,
        imageUrl: avatar_url.value,
        create_at: DateTime.now(),
      );
      Get.snackbar(
        'Success',
        'Account created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
