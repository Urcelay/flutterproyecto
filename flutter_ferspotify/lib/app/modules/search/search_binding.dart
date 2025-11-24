import 'package:get/get.dart';
import 'search_controller.dart';

/// Binding para el módulo de búsqueda
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchsController>(() => SearchsController());
  }
}
