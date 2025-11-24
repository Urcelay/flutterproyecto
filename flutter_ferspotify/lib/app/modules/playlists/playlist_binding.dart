import 'package:get/get.dart';
import 'playlist_controller.dart';

/// Binding para el módulo de playlists
class PlaylistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistController>(() => PlaylistController());
  }
}
