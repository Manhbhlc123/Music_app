import 'package:get/get.dart';
import 'package:sq_mp3/modules/setting/controller/Setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController(), fenix: true);
    
  }
  
}