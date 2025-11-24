import 'package:get/get.dart';
import '../../models/song_model.dart';
import '../../models/playlist_model.dart';
import '../../providers/auth_storage.dart';
import '../../providers/playlist_song_provider.dart';

/// Controller para manejar el detalle de una playlist
class PlaylistDetailController extends GetxController {
  var playlist = Rxn<Playlist>();
  var songs = <Song>[].obs;
  var isLoading = false.obs;

  late int playlistId;

  /// Inicializar con ID de playlist
  void init(int id) {
    playlistId = id;
    loadPlaylistSongs();
  }

  /// Cargar canciones de la playlist
  Future<void> loadPlaylistSongs() async {
    final token = await AuthStorage.getToken();
    if (token == null) {
      Get.snackbar("Error", "Debes iniciar sesión");
      return;
    }

    try {
      isLoading.value = true;
      final result = await PlaylistSongProvider.getPlaylistSongs(
        token,
        playlistId,
      );

      if (result != null) {
        playlist.value = result.lista;
        songs.assignAll(result.songs);
        print("✅ ${songs.length} canciones cargadas en la playlist");
      }
    } catch (e) {
      print("❌ Error al cargar playlist detalle: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Eliminar canción de la playlist
  Future<void> removeSong(int songId) async {
    final token = await AuthStorage.getToken();
    if (token == null) return;

    try {
      final result = await PlaylistSongProvider.removeSongFromPlaylist(
        token,
        playlistId,
        songId,
      );
      if (result != null) {
        Get.snackbar("Éxito", result.message);
        loadPlaylistSongs();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar la canción");
    }
  }
}
