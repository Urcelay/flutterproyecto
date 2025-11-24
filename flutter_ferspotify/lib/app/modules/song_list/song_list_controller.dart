import 'package:get/get.dart';

import '../../../app/models/song_model.dart';
import '../../../app/providers/music_provider.dart';

class SongListController extends GetxController {
  var songs = <Song>[].obs;
  var isLoading = false.obs;

  late String filterType;
  late int filterid;

  void initFilter(String type, int id) {
    filterType = type;
    filterid = id;
    loadSongs();
  }

  void loadSongs() async {
    isLoading.value = true;
    try {
      List<Song> result = [];
      if (filterType == "category") {
        result = await MusicProvider.getSong(category: filterid);
      } else if (filterType == "artist") {
        result = await MusicProvider.getSong(artist: filterid);
      } else if (filterType == "album") {
        result = await MusicProvider.getSong(album: filterid);
      }

      songs.assignAll(result);
    } catch (e) {
      print("Error en loadSongs: $e");
      songs.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
