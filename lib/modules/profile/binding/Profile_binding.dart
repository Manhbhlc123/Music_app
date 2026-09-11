import 'package:get/get.dart';
import 'package:sq_mp3/modules/profile/controller/Profile_controller.dart';

class ProfileBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(),);
  }
  
}