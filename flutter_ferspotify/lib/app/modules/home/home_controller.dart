import 'package:get/get.dart';

import '../../models/song_model.dart';
import '../../providers/music_provider.dart';

/// Controller para manejar la navegación entre tabs en el Home
class HomeController extends GetxController {
  /// Índice del tab seleccionado
  var currentIndex = 0.obs;

  var isLoading = false.obs;

  // Listas extraídas desde getSong
  var categories = <Category>[].obs;
  var artists = <Artist>[].obs;
  var albums = <Album>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  /// Llamar al endpoint /api/music/filter
  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final songs = await MusicProvider.getSong();

      final categorySet = <int, Category>{};
      final artistSet = <int, Artist>{};
      final albumSet = <int, Album>{};

      for (var song in songs){
        categorySet[song.idCategory] = song.category;
        artistSet[song.idArtist] = song.artist;
        albumSet[song.idAlbum] = song.album;
      }

      categories.assignAll(categorySet.values.toList());
      artists.assignAll(artistSet.values.toList());
      albums.assignAll(albumSet.values.toList());

      print("${categories.length} categorias, ${artists.length} artistas, ${albums.length} albumnes,");
    } catch (e) {
      print("❌ Error al obtener música: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Cambiar tab
  void changeTab(int index) {
    currentIndex.value = index;
    print("🔄 Cambiando tab a: $index");
  }
}
