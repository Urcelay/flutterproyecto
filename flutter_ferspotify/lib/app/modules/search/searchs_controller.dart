import 'package:get/get.dart';

/// Controller del módulo de búsqueda
class SearchsController extends GetxController {
  var query = ''.obs;

  void onSearch(String value) {
    query.value = value;
    print("🔎 Buscando: $value");
  }
}
