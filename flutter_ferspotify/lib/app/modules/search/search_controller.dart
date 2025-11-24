import 'package:get/get.dart';
import '../../models/song_model.dart';
import '../../providers/music_provider.dart';

/// Controller para manejar la búsqueda de canciones
class SearchsController extends GetxController {
  var query = ''.obs;
  var results = <Song>[].obs;
  var isLoading = false.obs;

  /// Método para realizar la búsqueda
  Future<void> searchSongs() async {
    if (query.value.isEmpty) {
      Get.snackbar("Aviso", "Debes ingresar un texto para buscar 🎵");
      results.clear();
      return;
    }

    try {
      isLoading.value = true;
      print("🔎 Buscando canciones con query: ${query.value}");

      final songs = await MusicProvider.searchSongs(query.value);

      results.assignAll(songs);
      print("✅ ${results.length} resultados encontrados");
    } catch (e) {
      print("❌ Error en búsqueda: $e");
      results.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
