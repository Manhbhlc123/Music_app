import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/controller/SignUp_controller.dart';

import '../../../core/services/Token_service.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TokenService>(() => TokenService());
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
