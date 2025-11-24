import 'package:get/get.dart';
import 'home_controller.dart';
import '../search/searchs_controller.dart';

/// Binding para inyectar el HomeController
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<SearchsController>(() => SearchsController());
  }
}