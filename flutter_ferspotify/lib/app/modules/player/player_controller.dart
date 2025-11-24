import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/song_model.dart';
import '../../models/playlist_model.dart';
import '../../../app/providers/music_provider.dart';
import '../../../app/providers/playlist_provider.dart';
import '../../../app/providers/playlist_song_provider.dart';
import '../../../app/providers/auth_storage.dart';

/// Controller para manejar la reproducción de música
class PlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  var songs = <Song>[].obs;
  var currentIndex = 0.obs;
  var isPlaying = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;

  var isFavorite = false.obs; // ❤️ Favoritos
  var isLiked = false.obs; // 👍 Likes
  var playlists = <Playlist>[].obs; // 📂 Playlists del usuario

  void init(List<Song> songList, int startIndex) {
    songs.assignAll(songList);
    currentIndex.value = startIndex;
    _loadSong();
  }

  Future<void> _loadSong() async {
    final song = songs[currentIndex.value];
    try {
      await audioPlayer.setUrl(song.fileUrl);
      duration.value = audioPlayer.duration ?? Duration.zero;

      // Registrar reproducción en backend
      await MusicProvider.playSong(song.id);

      // Verificar favoritos
      await _checkIfFavorite(song.id);

      play();
    } catch (e) {
      print("❌ Error al cargar la canción: $e");
    }
  }

  /// ▶️ Reproducir
  void play() {
    audioPlayer.play();
    isPlaying.value = true;
  }

  /// ⏸️ Pausar
  void pause() {
    audioPlayer.pause();
    isPlaying.value = false;
  }

  void togglePlayPause() {
    isPlaying.value ? pause() : play();
  }

  /// ⏭️ Canción siguiente
  void next() {
    if (currentIndex.value < songs.length - 1) {
      currentIndex.value++;
      _loadSong();
    }
  }

  /// ⏮️ Canción anterior
  void previous() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      _loadSong();
    }
  }

  /// ❤️ Alternar favoritos
  Future<void> toggleFavorite() async {
    final song = songs[currentIndex.value];
    final token = await AuthStorage.getToken();
    if (token == null) {
      Get.snackbar("Error", "Debes iniciar sesión para usar favoritos");
      return;
    }

    final result = await MusicProvider.toggleFavorite(token, song.id);
    if (result != null) {
      isFavorite.toggle();
      Get.snackbar(
        "Favoritos",
        isFavorite.value
            ? "Agregaste a favoritos ❤️"
            : "Eliminaste de favoritos 💔",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 👍 Like a la canción
  Future<void> likeSong() async {
    final song = songs[currentIndex.value];
    final result = await MusicProvider.likeSong(song.id);
    if (result != null) {
      isLiked.value = true;
      Get.snackbar(
        "Like",
        "Le diste like 👍",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 📂 Cargar playlists del usuario
  Future<void> loadPlaylists() async {
    final token = await AuthStorage.getToken();
    final userId = await AuthStorage.getUserId();
    if (token == null || userId == null) return;

    final result = await PlaylistProvider.getUserPlaylists(
      userId: userId,
      token: token,
    );
    playlists.assignAll(result);
  }

  /// 📂 Agregar canción actual a una playlist
  Future<void> addSongToPlaylist(int playlistId) async {
    final token = await AuthStorage.getToken();
    if (token == null) return;

    final song = songs[currentIndex.value];
    final result = await PlaylistSongProvider.addSongsToPlaylist(
      token,
      playlistId,
      [song.id],
    );

    if (result != null) {
      Get.snackbar(
        "Playlist",
        "Canción añadida a la playlist 🎶",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Verificar si la canción está en favoritos (puedes mejorar usando endpoint de favoritos directos)
  Future<void> _checkIfFavorite(int songId) async {
    // Aquí podrías optimizar llamando al endpoint de favoritos y verificando si está
    isFavorite.value = false; // Por ahora en false hasta implementar
  }

  @override
  void onInit() {
    super.onInit();

    // Escuchar cambios de posición
    audioPlayer.positionStream.listen((pos) {
      position.value = pos;
    });

    // Escuchar duración
    audioPlayer.durationStream.listen((dur) {
      if (dur != null) duration.value = dur;
    });

    // Avanzar automáticamente a la siguiente canción
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        next();
      }
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
