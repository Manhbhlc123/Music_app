import 'package:get/get.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';
import 'package:sq_mp3/modules/player/controller/Queue_controller.dart';

class PlayerBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => QueueController(), fenix: true);
    Get.lazyPut(() => PlayerController(), fenix: true);
  }

}