import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/home/home_binding.dart'; // ⬅️ IMPORTANTE importar el binding

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',

      // ⬅️ AÑADIR ESTO
      initialBinding: HomeBinding(),

      // ⬅️ Mantienes tus rutas
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
