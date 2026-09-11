import 'package:get/get.dart';
import 'package:sq_mp3/modules/favorite/controller/Favorite_controller.dart';

class FavoriteBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }

}