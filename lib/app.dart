import 'package:call_service/src/config/theme/themes.dart';
import 'package:call_service/src/core/locale/translation.dart';
import 'package:call_service/src/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class CallServiceApp extends StatelessWidget {
  const CallServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      translations: TranslationsWords(),
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.StartScreenRoute,
      getPages: Routes.routes,
    );
  }
}
