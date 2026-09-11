import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';
import 'package:sq_mp3/modules/admin/widget/UserManagement_widget/User_section.dart';

class UserManageView extends GetView<AdminController> {
  const UserManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Management",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        actions: [IconButton(onPressed: () {Get.toNamed(Routes.createUserFromAdminPage);}, icon: Icon(Icons.add))],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : UserSection(
                listUser: controller.users,
                onEdit: controller.updateUser,
                onRemove: controller.deleteUser,
              ),
      ),
    );
  }
}
