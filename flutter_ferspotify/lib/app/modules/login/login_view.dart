import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'login_controller.dart';

/// Vista de Login.
/// Incluye campos básicos de email y password.
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 24),
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.login,
                      child: const Text("Ingresar"),
                    ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.REGISTER),
              child: const Text("¿No tienes cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
