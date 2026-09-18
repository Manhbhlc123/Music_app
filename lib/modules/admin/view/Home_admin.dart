import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class HomeAdmin extends GetView<AdminController> {
  const HomeAdmin({super.key});

  // Hiển thị panel bên phải
  void showRightPanel(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Admin Menu",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),

      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.7,

              child: Column(
                children: [
                  // Header của panel
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Menu Admin",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  // Các chức năng
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text("Quản lý người dùng"),
                    onTap: () {
                      Get.toNamed(Routes.userManagement);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.music_note),
                    title: const Text("Quản lý bài hát"),
                    onTap: () {
                      Get.toNamed(Routes.songManagement);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.album),
                    title: const Text("Quản lý album"),
                    onTap: () {
                      Get.toNamed(Routes.albumManagement);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.playlist_add_check_sharp),
                    title: const Text("Quản lý Playlist"),
                    onTap: () {
                      Get.toNamed(Routes.playlistManagement);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Quản lý nghệ sĩ"),
                    onTap: (){
                      Get.toNamed(Routes.artistManagement);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text("Quản lý thể loại"),
                    onTap: (){
                      Get.toNamed(Routes.genreManagement);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },

      // Animation trượt từ phải sang
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trang chủ ADMIN",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () => showRightPanel(context),
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildStatCard(
                      context,
                      title: "Người dùng",
                      count: controller.userCount.value.toString(),
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                    _buildStatCard(
                      context,
                      title: "Bài hát",
                      count: controller.songCount.value.toString(),
                      icon: Icons.music_note,
                      color: Colors.orange,
                    ),
                    _buildStatCard(
                      context,
                      title: "Album",
                      count: controller.albumCount.value.toString(),
                      icon: Icons.album,
                      color: Colors.purple,
                    ),
                    _buildStatCard(
                      context,
                      title: "Playlist",
                      count: controller.playlistCount.value.toString(),
                      icon: Icons.category,
                      color: Colors.green,
                    ),
                    _buildStatCard(
                      context,
                      title: "Nghệ sĩ",
                      count: controller.artistCount.value.toString(),
                      icon: Icons.person,
                      color: Colors.red,
                    ),
                    _buildStatCard(
                      context,
                      title: "Thể loại",
                      count: controller.genreCount.value.toString(),
                      icon: Icons.category,
                      color: Colors.teal,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(title, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
