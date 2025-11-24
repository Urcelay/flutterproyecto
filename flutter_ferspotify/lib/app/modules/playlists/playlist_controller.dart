import 'package:get/get.dart';
import '../../models/playlist_model.dart';
import '../../providers/playlist_provider.dart';
import '../../providers/auth_storage.dart';

/// Controller para manejar las playlists del usuario
class PlaylistController extends GetxController {
  var playlists = <Playlist>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPlaylists();
  }

  /// Cargar todas las playlists del usuario autenticado
  Future<void> loadPlaylists() async {
    final token = await AuthStorage.getToken();
    final userId = await AuthStorage.getUserId();

    if (token == null || userId == null) {
      Get.snackbar("Error", "Debes iniciar sesión para ver tus playlists");
      return;
    }

    try {
      isLoading.value = true;
      final result = await PlaylistProvider.getUserPlaylists(
        userId: userId, token:token
      );

      playlists.assignAll(result);

      print("✅ ${playlists.length} playlists cargadas");

      isLoading.value = false;
    } catch (e) {
      print("❌ Error al cargar playlists: $e");
      playlists.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Crear nueva playlist
  Future<void> createPlaylist(String name, bool isPublic) async {
    final token = await AuthStorage.getToken();
    if (token == null) return;

    try {
      final result = await PlaylistProvider.createPlaylist(
        token,
        name,
        isPublic,
      );
      if (result != null) {
        Get.snackbar("Éxito", "Playlist creada correctamente");
        loadPlaylists();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo crear la playlist");
    }
  }

  /// Editar playlist
  Future<void> updatePlaylist(int id, String name, bool isPublic) async {
    final token = await AuthStorage.getToken();
    if (token == null) return;

    try {
      final result = await PlaylistProvider.updatePlaylist(
        token,
        id,
        name,
        isPublic,
      );
      if (result != null) {
        Get.snackbar("Éxito", "Playlist actualizada");
        loadPlaylists();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo actualizar la playlist");
    }
  }

  /// Eliminar playlist
  Future<void> deletePlaylist(int id) async {
    final token = await AuthStorage.getToken();
    if (token == null) return;

    try {
      final result = await PlaylistProvider.deletePlaylist(token,id);
      if (result != null) {
        Get.snackbar("Éxito", "Playlist eliminada");
        loadPlaylists();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar la playlist");
    }
  }
}
