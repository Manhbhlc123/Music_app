import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/User_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/widget/UserManagement_widget/UpdateUser_dialog.dart';

class UserItem extends StatelessWidget {
  final UserModel userModel;

  final Function(UserModel)? onUpdate;
  final VoidCallback? onDelete;

  const UserItem({
    super.key,
    required this.userModel,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: userModel.avatar_url.isNotEmpty
            ? NetworkImage(userModel.avatar_url)
            : null,
        child: userModel.avatar_url.isEmpty
            ? Text(userModel.name[0].toUpperCase())
            : null,
      ),
      title: Text(userModel.name),
      subtitle: Text(userModel.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              final updatedUser = await showDialog<UserModel>(
                context: context,
                builder: (context) {
                  return UpdateUserDialog(user: userModel);
                },
              );
              if (updatedUser != null) {
                onUpdate?.call(updatedUser);
              }
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Confirm Delete"),
                  content: Text(
                    "Are you sure you want to delete ${userModel.name}?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        onDelete?.call();
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
