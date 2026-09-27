import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/setting/controller/Setting_controller.dart';

class SettingHomeView extends GetView<SettingController> {
  const SettingHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Obx(() {
        if(controller.isLoading.value)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                value: controller.isOnlyWifi.value,
                onChanged: (bool value) async {
                  controller.isOnlyWifi.value = value;
                  await controller.updateUserSetting();
                },
                title: Text("Download khi có wifi"),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                value: controller.notificationEnabled.value,
                onChanged: (bool value) async {
                  controller.notificationEnabled.value = value;
                  await controller.updateUserSetting();
                },
                title: Text("Thông báo"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
