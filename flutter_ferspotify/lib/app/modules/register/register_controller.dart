import 'package:get/get.dart';
import '../../providers/auth_provider.dart';
import '../../providers/auth_storage.dart';
import '../../routes/app_routes.dart';

/// Controller para manejar la lógica de Register.
/// Conecta con AuthProvider y guarda token + user_id en AuthStorage.
class RegisterController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isLoading = false.obs;

  /// Método para registrar usuario
  Future<void> register() async {
    if (name.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      Get.snackbar("Error", "Por favor, completa todos los campos");
      return;
    }

  //validacion
  if (password.value != confirmPassword.value) {
    Get.snackbar("Error", "Las contraseñas no coinciden");
    return;
  }

    try {
      isLoading.value = true;
      print(
        "📝 Enviando registro con: ${name.value}, ${email.value}, ${password.value}",
      );

      // Llamada al AuthProvider (ajusta el método si tu API usa otra firma)
      final response = await AuthProvider.register(
        name.value,
        email.value,
        password.value,
      );

      print("✅ Registro correcto: ${response.toString()}");

      // Guardar token y user_id en SharedPreferences / Storage
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
      print("❌ Error en registro: $e");
      Get.snackbar(
        "Error",
        "No se pudo registrar el usuario o hubo un error en el servidor",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
