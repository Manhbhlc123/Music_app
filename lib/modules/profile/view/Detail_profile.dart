import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/profile/controller/Profile_controller.dart';

class DetailProfile extends GetView<ProfileController> {
  const DetailProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin cá nhân")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

        if (user == null) {
          return const Center(child: Text("Không có dữ liệu"));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatar_url),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Tên"),
              subtitle: Text(user.name),
            ),

            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(user.email),
            ),

            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Số điện thoại"),
              subtitle: Text(user.phone),
            ),

            ListTile(
              leading: const Icon(Icons.public),
              title: const Text("Quốc gia"),
              subtitle: Text(user.country),
            ),

            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text("VIP"),
              subtitle: Text(user.is_vip ? "Có" : "Không"),
            ),
          ],
        );
      }),
    );
  }
}