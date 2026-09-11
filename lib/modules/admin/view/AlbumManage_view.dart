import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class AlbumManageView extends GetView<AdminController> {
  const AlbumManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album Management", style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,),
      ),
    );
  }

}