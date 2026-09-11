import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/bindings/Initial_binding.dart';
import 'package:sq_mp3/app/routes/App_pages.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/app/theme/App_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: const MyApp(),
      supportedLocales: const [Locale('vi'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      initialRoute: Routes.login,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Apptheme.darkTheme,
      themeMode: ThemeMode.system,
      title: 'SQ MP3',
      debugShowCheckedModeBanner: false,
    );
  }
}
