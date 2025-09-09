import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/languages/language.dart';
import 'config/route/app_routes.dart';
import 'config/theme/light_theme.dart';
import 'config/dependency/dependency_injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        defaultTransition: Transition.fadeIn,
        theme: themeData,
        transitionDuration: const Duration(milliseconds: 300),
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
        initialBinding: DependencyInjection(),
        // Language configuration
        translations: LocalConstants(),
        locale: const Locale('es', 'ES'), // Default language: Spanish
        fallbackLocale: const Locale('es', 'ES'), // Fallback language
        supportedLocales: const [
          Locale('es', 'ES'), // Spanish
          Locale('en', 'US'), // English
        ],
        // Add localization delegates
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
