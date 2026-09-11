import 'package:get/get.dart';
import 'package:sq_mp3/modules/search/controller/Search_controller.dart';

class SearchBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchControllerHome());
  }

}