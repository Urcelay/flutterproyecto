import 'package:get/get.dart';
import 'favorites_controller.dart';

/// Binding para el módulo de favoritos
class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() => FavoritesController());
  }
}
