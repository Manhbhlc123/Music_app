import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/UserSetting.dart';
import 'package:sq_mp3/data/provider/UserSetting_api_provider.dart';

class SettingController extends GetxController {
  final UserSettingApiProvider userSettingApiProvider =
  UserSettingApiProvider();

  final tokenService = TokenService();

  RxBool isOnlyWifi = false.obs;
  RxBool notificationEnabled = false.obs;
  RxMap<String, dynamic> equalizerPreset = <String, dynamic>{}.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettingPage();
  }

  Future<void> loadSettingPage() async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final userSetting = await userSettingApiProvider.getUserSetting(token);

      isOnlyWifi.value = userSetting.downloadOnlyWifi;
      notificationEnabled.value = userSetting.notificationEnabled;

      equalizerPreset.value = userSetting.equalizerPreset;
    } catch (e) {
      print("LOAD SETTING ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserSetting() async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final userSetting = UserSetting(
        downloadOnlyWifi: isOnlyWifi.value,
        notificationEnabled: notificationEnabled.value,
        equalizerPreset: equalizerPreset,
      );

      print("UPDATE SETTING: ${userSetting.toJson()}");

      await userSettingApiProvider.updateDownload(
        token,
        userSetting,
      );

      // Load lại từ server
      await loadSettingPage();

    } catch (e) {
      print("UPDATE SETTING ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }
}