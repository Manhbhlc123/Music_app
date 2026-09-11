import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart' hide Trans;
import 'package:sq_mp3/modules/home/controller/SignUp_controller.dart';

class CreateUser extends GetView<SignUpController> {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          "signup.title".tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white12),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white60,
                    backgroundImage: controller.avatar_url.value.isNotEmpty
                        ? NetworkImage(controller.avatar_url.value)
                        : null,
                    child: controller.avatar_url.value.isEmpty
                        ? Icon(Icons.person, size: 80, color: Colors.grey)
                        : null,
                  ),
                ),

                //user name
                const SizedBox(height: 20),
                TextField(
                  controller: controller.tenUser,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: "signup.username_hint".tr(),
                    labelText: "signup.username_label".tr(),
                  ),
                ),

                //phone
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: "signup.phone_hint".tr(),
                    labelText: "signup.phone_label".tr(),
                  ),
                ),

                //email
                const SizedBox(height: 10),
                TextField(
                  controller: controller.email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: "signup.email_hint".tr(),
                    labelText: "signup.email_label".tr(),
                  ),
                ),

                //password
                const SizedBox(height: 10),
                TextField(
                  controller: controller.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: "signup.password_hint".tr(),
                    labelText: "signup.password_label".tr(),
                  ),
                ),

                //repassword
                const SizedBox(height: 10),
                TextField(
                  controller: controller.repassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: "signup.confirm_password_hint".tr(),
                    labelText: "signup.confirm_password_label".tr(),
                  ),
                ),

                //select birthday year
                const SizedBox(height: 10),
                DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 12,
                  menuHeight: 250,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(),
                  ),
                  hintText: "signup.birthday_hint".tr(),
                  dropdownMenuEntries: controller.signUpService
                      .getBirthDayYear()
                      .map(
                        (year) => DropdownMenuEntry(
                          value: year.toString(),
                          label: year.toString(),
                        ),
                      )
                      .toList(),
                  onSelected: (String? value) =>
                      controller.selectedYear = int.tryParse(value ?? ""),
                ),

                //select country
                const SizedBox(height: 10),
                DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 12,
                  menuHeight: 250,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(),
                  ),
                  hintText: "signup.country_hint".tr(),
                  dropdownMenuEntries: <DropdownMenuEntry<String>>[
                    DropdownMenuEntry(
                      value: "Vietnam",
                      label: "signup.country.vietnam".tr(),
                    ),
                    DropdownMenuEntry(
                      value: "USA",
                      label: "signup.country.usa".tr(),
                    ),
                    DropdownMenuEntry(
                      value: "Japan",
                      label: "signup.country.japan".tr(),
                    ),
                    DropdownMenuEntry(
                      value: "Korea",
                      label: "signup.country.korea".tr(),
                    ),
                  ],
                  onSelected: (String? value) =>
                      controller.selectedCountry = value,
                ),

                //select language
                const SizedBox(height: 10),
                DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 12,
                  menuHeight: 250,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(),
                  ),
                  hintText: "signup.language_hint".tr(),
                  dropdownMenuEntries: <DropdownMenuEntry<String>>[
                    DropdownMenuEntry(
                      value: "vi",
                      label: "signup.language.vi".tr(),
                    ),
                    DropdownMenuEntry(
                      value: "en",
                      label: "signup.language.en".tr(),
                    ),
                  ],
                  onSelected: (String? value) => controller.language = value,
                ),

                //choose avatar
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text("signup.avatar".tr()),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () async {
                        // Assuming storageService is accessible via controller
                        String? url = await controller.storageService
                            .uploadImage();
                        if (url != null) {
                          controller.avatar_url.value = url;
                        }
                      },
                      icon: Icon(Icons.camera_enhance),
                    ),
                  ],
                ),

                //button sign up
                const SizedBox(height: 20),
                Obx(
                  () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => controller.signUp(),
                          child: Text("Add"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
