import '../../../app/models/album_model.dart';
import '../../../app/models/artist_model.dart';
import '../../../app/models/category_model.dart';
import 'package:get/get.dart';

import '../../models/song_model.dart';
import '../../providers/music_provider.dart';


/// Controller para manejar la navegación entre tabs en el Home
class HomeController extends GetxController {
  /// Índice del tab seleccionado
  var selectedIndex = 0.obs;

  var isLoading = false.obs;

  // Listas extraídas desde getSong
  var categories = <CategoryModel>[].obs;
  var artists = <ArtistModel>[].obs;
  var albums = <AlbumModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMusicData();
  }

  /// Cambiar tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  /// Llamar al endpoint /api/music/filter
  Future<void> fetchMusicData() async {
    try {
      isLoading.value = true;
      final songs = await MusicProvider.getSong();

      if (songs != null) {
        // Extraer categorías únicas
        categories.assignAll(
          {
            for (var s in songs) s.category?.id: s.category,
          }.values
              .whereType<CategoryModel>()
              .toList(),
        );

        // Extraer artistas únicos
        artists.assignAll(
          {
            for (var s in songs) s.artist?.id: s.artist,
          }.values
              .whereType<ArtistModel>()
              .toList(),
        );

        // Extraer álbumes únicos
        albums.assignAll(
          {
            for (var s in songs) s.album?.id: s.album,
          }.values
              .whereType<AlbumModel>()
              .toList(),
        );
      }
    } catch (e) {
      print("❌ Error al obtener música: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
