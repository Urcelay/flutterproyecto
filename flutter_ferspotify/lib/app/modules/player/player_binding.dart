import 'package:get/get.dart';
import 'player_controller.dart';

/// Binding para Register.
class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerController>(() => PlayerController());
  }
}
