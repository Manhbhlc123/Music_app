import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/User_model.dart';
import 'package:sq_mp3/data/provider/User_api_provider.dart';

class ProfileController extends GetxController
{
  final UserApiProvider apiProvider = UserApiProvider();
  final TokenService tokenService = TokenService();

  var isLoading = true.obs;
  Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      isLoading(true);
      final token = await tokenService.getToken();
      if (token == null) {
        Get.snackbar("Error", "Session expired. Please login again.");
        Get.offAllNamed('/login');
        return;
      }
      final userData = await apiProvider.getUser(token);
      if (userData != null) {
        user.value = userData;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    await tokenService.deleteToken();
    // user.value = null;
    Get.offAllNamed('/login');
  }

  void goToUserProfile()
  {
    Get.toNamed(Routes.detailProfile);
  }
}