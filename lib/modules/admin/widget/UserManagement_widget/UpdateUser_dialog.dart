import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/User_model.dart';

class UpdateUserDialog extends StatefulWidget {
  final UserModel user;

  const UpdateUserDialog({
    super.key,
    required this.user,
  });

  @override
  State<UpdateUserDialog> createState() => _UserUpdateDialogState();
}

class _UserUpdateDialogState extends State<UpdateUserDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayYearController;
  late TextEditingController countryController;
  late TextEditingController avatarUrlController;
  late TextEditingController languageController;
  late TextEditingController roleController;
  late TextEditingController statusController;

  bool isVip = false;
  bool vipAutoRenew = false;
  bool twoFactorEnable = false;

  DateTime? vipExpiredAt;
  DateTime? updateAt;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.user.name);

    emailController =
        TextEditingController(text: widget.user.email);


    phoneController =
        TextEditingController(text: widget.user.phone);

    birthdayYearController = TextEditingController(
      text: widget.user.birthdayYear.toString(),
    );

    countryController =
        TextEditingController(text: widget.user.country);

    avatarUrlController = TextEditingController(
      text: widget.user.avatar_url);

    languageController = TextEditingController(text: widget.user.language);
    roleController = TextEditingController(text: widget.user.role);
    statusController = TextEditingController(text: widget.user.status);

    isVip = widget.user.is_vip ?? false;
    vipAutoRenew = widget.user.vip_auto_renew ?? false;
    twoFactorEnable = widget.user.two_factor_enable ?? false;
    vipExpiredAt = widget.user.vip_expired_at;
    updateAt = widget.user.update_at;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdayYearController.dispose();
    countryController.dispose();
    avatarUrlController.dispose();
    languageController.dispose();
    roleController.dispose();
    statusController.dispose();

    super.dispose();
  }

  Future<void> selectVipExpiredAt() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: vipExpiredAt ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        vipExpiredAt = picked;
      });
    }
  }

  Future<void> selectUpdateAt() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: updateAt ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        updateAt = picked;
      });
    }
  }

  void updateUser() {
    final updatedUser = widget.user.copyWith(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      birthdayYear: int.tryParse(birthdayYearController.text.trim()) ?? widget.user.birthdayYear,
      country: countryController.text.trim(),
      avatar_url: avatarUrlController.text.trim(),
      language: languageController.text.trim(),
      role: roleController.text.trim(),
      is_vip: isVip,
      vip_auto_renew: vipAutoRenew,
      vip_expired_at: vipExpiredAt,
      two_factor_enable: twoFactorEnable,
      status: statusController.text.trim(),
      update_at: updateAt,
    );
    print("👉 CHỐT 1 - DIALOG TRẢ VỀ TUỔI: ${updatedUser.birthdayYear}");
    Get.back(result: updatedUser);
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Cập nhật thông tin User",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      content: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // NAME
              TextField(
                controller: nameController,
                decoration: inputDecoration("Tên"),
              ),

              const SizedBox(height: 12),

              // EMAIL
              TextField(
                controller: emailController,
                decoration: inputDecoration("Email"),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 12),

              // PHONE
              TextField(
                controller: phoneController,
                decoration: inputDecoration("Số điện thoại"),
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 12),

              // BIRTHDAY YEAR
              TextField(
                controller: birthdayYearController,
                decoration: inputDecoration("Năm sinh"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 12),

              // COUNTRY
              TextField(
                controller: countryController,
                decoration: inputDecoration("Quốc gia"),
              ),

              const SizedBox(height: 12),

              // AVATAR
              TextField(
                controller: avatarUrlController,
                decoration: inputDecoration("Avatar URL"),
              ),

              const SizedBox(height: 12),

              // LANGUAGE
              TextField(
                controller: languageController,
                decoration: inputDecoration("Ngôn ngữ"),
              ),

              const SizedBox(height: 12),

              // ROLE
              TextField(
                controller: roleController,
                decoration: inputDecoration("Role"),
              ),

              const SizedBox(height: 12),

              // STATUS
              TextField(
                controller: statusController,
                decoration: inputDecoration("Status"),
              ),

              const SizedBox(height: 10),

              // VIP
              SwitchListTile(
                title: const Text("VIP"),
                value: isVip,
                onChanged: (value) {
                  setState(() {
                    isVip = value;
                  });
                },
              ),

              // AUTO RENEW
              SwitchListTile(
                title: const Text("Tự động gia hạn VIP"),
                value: vipAutoRenew,
                onChanged: (value) {
                  setState(() {
                    vipAutoRenew = value;
                  });
                },
              ),

              // 2FA
              SwitchListTile(
                title: const Text("Xác thực 2 yếu tố"),
                value: twoFactorEnable,
                onChanged: (value) {
                  setState(() {
                    twoFactorEnable = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              // VIP EXPIRED
              ListTile(
                title: const Text("Ngày hết hạn VIP"),
                subtitle: Text(
                  vipExpiredAt == null
                      ? "Chưa chọn"
                      : vipExpiredAt!
                      .toIso8601String()
                      .split('T')
                      .first,
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: selectVipExpiredAt,
              ),

              // UPDATE AT
              ListTile(
                title: const Text("Ngày cập nhật"),
                subtitle: Text(
                  updateAt == null
                      ? "Chưa chọn"
                      : updateAt!
                      .toIso8601String()
                      .split('T')
                      .first,
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: selectUpdateAt,
              ),
            ],
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Hủy"),
        ),

        ElevatedButton(
          onPressed: updateUser,
          child: const Text("Cập nhật"),
        ),
      ],
    );
  }
}