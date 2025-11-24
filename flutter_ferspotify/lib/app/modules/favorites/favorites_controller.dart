import 'package:get/get.dart';
import '../../models/song_model.dart';
import '../../providers/music_provider.dart';
import '../../providers/auth_storage.dart';

/// Controller para manejar las canciones favoritas del usuario
class FavoritesController extends GetxController {
  var favorites = <Song>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  /// Cargar canciones favoritas desde el backend
  Future<void> loadFavorites() async {
    final token = await AuthStorage.getToken();

    if (token == null) {
      Get.snackbar("Error", "Debes Iniciar sesión para ver tus favoritos");
      return;
    }

    try {
      isLoading.value = true;
      print("📥 Obteniendo canciones favoritas...");
      final result = await MusicProvider.getFavorites(token);
      favorites.assignAll(result);
      print("✅ ${favorites.length} canciones favoritas cargadas");
    } catch (e) {
      print("❌ Error al cargar favoritos: $e");
      favorites.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Eliminar una canción de favoritos
  Future<void> removeFromFavorites(int songId) async {
    final token = await AuthStorage.getToken();

    if (token == null) {
      Get.snackbar("Error", "Debes iniciar sesión para gestionar favoritos");
      return;
    }

    try {
      final result = await MusicProvider.toggleFavorite(token, songId);
      if (result != null) {
        favorites.removeWhere((song) => song.id == songId);
        Get.snackbar("Favoritos", "Canción eliminada de favoritos 💔");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar de favoritos");
    }
  }
}
