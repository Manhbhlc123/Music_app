import 'package:get/get.dart';
import 'package:sq_mp3/modules/library/controller/Download_controller.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';

class LibraryBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => LibraryController(), fenix: true);
    Get.lazyPut(() => DownloadController(), fenix: true);
  }

}