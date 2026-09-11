import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/User_model.dart';
import 'package:sq_mp3/modules/admin/widget/UserManagement_widget/User_item.dart';

class UserSection extends StatelessWidget {
  final List<UserModel> listUser;
  final Function(UserModel user) onEdit;
  final Function(String userId) onRemove;

  const UserSection({
    super.key,
    required this.listUser,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        UserModel user = listUser[index];
        return UserItem(
          userModel: user,
          onUpdate: (updatedUser) => onEdit(updatedUser),
          onDelete: () => onRemove(user.id),
        );
      },
      itemCount: listUser.length,
    );
  }
}
