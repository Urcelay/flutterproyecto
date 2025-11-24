import 'package:get/get.dart';
import 'login_controller.dart';

/// Binding para inyectar dependencias en Login.
/// Crea la instancia de LoginController cuando se entra a la vista.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
