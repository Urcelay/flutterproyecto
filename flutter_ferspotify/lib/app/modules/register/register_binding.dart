import 'package:get/get.dart';
import 'register_controller.dart';

/// Binding para Register.
class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
