import 'package:get/get.dart';
import 'package:sq_mp3/data/provider/Album_api_provider.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/data/provider/User_api_provider.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class AdminBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => AdminController(), fenix: true);
    Get.lazyPut(() => UserApiProvider(),);
    Get.lazyPut(() => SongApiProvider(),);
    Get.lazyPut(() => PlaylistProvider(),);
    Get.lazyPut(() => AlbumApiProvider(),);
  }

}