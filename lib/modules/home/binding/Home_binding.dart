import 'package:get/get.dart';
import 'package:sq_mp3/modules/favorite/controller/Favorite_controller.dart';
import 'package:sq_mp3/modules/home/binding/PlaylistDetail_controller.dart';
import 'package:sq_mp3/modules/home/controller/AlbumController.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';
import 'package:sq_mp3/modules/home/controller/PlaylistController.dart';
import 'package:sq_mp3/modules/library/controller/Download_controller.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';
import 'package:sq_mp3/modules/player/controller/Queue_controller.dart';
import 'package:sq_mp3/modules/profile/controller/Profile_controller.dart';
import 'package:sq_mp3/modules/search/controller/Search_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchControllerHome(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => LibraryController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => PlayerController(), fenix: true);
    Get.lazyPut(() => QueueController(), fenix: true);
    Get.lazyPut(() => PlaylistDetailController(), fenix: true);
    Get.lazyPut(() => PlaylistController(), fenix: true);
    Get.lazyPut(() => DownloadController(), fenix: true);
    Get.lazyPut(() => AlbumController(), fenix: true);
  }
}
