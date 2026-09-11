import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/controller/SongsOfArtist_controller.dart';

class SongsOfArtistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongsOfArtistController>(() => SongsOfArtistController(), fenix: true);
  }
}
