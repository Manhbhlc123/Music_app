import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/profile/controller/Profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cá nhân",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [

              Obx(() {
                if (controller.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                final user = controller.user.value;

                return GestureDetector(
                  onTap: controller.goToUserProfile,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                        user!.avatar_url.isNotEmpty
                            ? NetworkImage(
                          user.avatar_url,
                        )
                            : null,
                        child: user.avatar_url.isEmpty
                            ? const Icon(Icons.person)
                            : null,
                      ),

                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: const Text(
                        "Xem trang cá nhân",
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      ),
                    ),
                  ),
                );
              }),

              const Divider(),

              ListTile(
                leading: const Icon(
                  Icons.workspace_premium,
                  color: Colors.amber,
                ),
                title: const Text(
                  "Nâng VIP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  "Trải nghiệm âm nhạc không quảng cáo",
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
              ),

              Obx(() {
                if (controller.user.value?.role == 'ADMIN') {
                  return ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text("Chuyển trang admin"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                    ),
                    onTap: () => Get.toNamed(Routes.adminHome),
                  );
                }
                return const SizedBox.shrink();
              }),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: controller.logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 45),
                ),
                child: const Text("Đăng Xuất"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}