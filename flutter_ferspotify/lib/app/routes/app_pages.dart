import 'package:get/get.dart';

import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';

import '../modules/register/register_binding.dart';
import '../modules/register/register_view.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';

import 'app_routes.dart';

/// Definición de las páginas (GetX)
/// Cada ruta tiene su vista y su binding correspondiente.
class AppPages {
  static const INITIAL = AppRoutes.LOGIN;

  static final routes = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
