import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'register_controller.dart';

/// Vista de Register.
/// Incluye campos de nombre, email y password.
class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Nombre"),
              onChanged: (val) => controller.name.value = val,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: (val) => controller.email.value = val,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              onChanged: (val) => controller.password.value = val,
            ),

            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: "Confirmar Password",
              ),
              obscureText: true,
              onChanged: (val) => controller.confirmPassword.value = val,
            ),

            const SizedBox(height: 24),

            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.register,
                      child: const Text("Registrar"),
                    ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.LOGIN),
              child: const Text("¿Ya tienes cuenta? Inicia sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
