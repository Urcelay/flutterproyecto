import 'package:get/get.dart';
import '../../providers/auth_provider.dart';
import '../../providers/auth_storage.dart';
import '../../routes/app_routes.dart';

/// Controller para manejar la lógica de Login.
/// Conecta con AuthProvider y guarda token + user_id en AuthStorage.
class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  /// Método para iniciar sesión
  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Error", "Por favor, completa todos los campos");
      return;
    }

    try {
      isLoading.value = true;
      print("📤 Enviando login con: ${email.value}, ${password.value}");

      // Llamada al AuthProvider
      final response = await AuthProvider.login(email.value, password.value);

      if (response != null) {
        print("✅ Login correcto: ${response.toJson()}");

        // Guardar token y user_id
        await AuthStorage.saveAuthData(
          token: response.token ?? "",
          userId: response.user?.id ?? 0,
        );

        // Navegar al Home
        Get.offAllNamed(AppRoutes.HOME);
      } else {
        print("❌ Login fallido: respuesta nula");
        Get.snackbar("Error", "No se pudo iniciar sesión");
      }
    } catch (e) {
      print("❌ Error en login: $e");
      Get.snackbar("Error", "Credenciales inválidas o error en el servidor");
    } finally {
      isLoading.value = false;
    }
  }
}
