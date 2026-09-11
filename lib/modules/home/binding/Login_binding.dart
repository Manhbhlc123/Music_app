import 'package:get/get.dart';
import 'package:sq_mp3/data/provider/Auth_api_provider.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';
import 'package:sq_mp3/modules/home/controller/Login_controller.dart';

class LoginBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthApiProvide());
    Get.lazyPut(() => LoginController(),);
    Get.lazyPut(() => HomeController(),);
  }

}