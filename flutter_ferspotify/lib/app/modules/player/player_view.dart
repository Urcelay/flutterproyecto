import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'player_controller.dart';

class PlayerView extends StatelessWidget {
  final List songs;
  final int startIndex;

  const PlayerView({super.key, required this.songs, required this.startIndex});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerController());
    controller.init(songs.cast(), startIndex);

    return Scaffold(
      appBar: AppBar(title: const Text("🎶 Reproductor"), centerTitle: true),
      body: Obx(() {
        final song = controller.songs[controller.currentIndex.value];

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🎵 Cover con animación
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: song.coverImage != null
                      ? Image.network(
                          song.coverImage!,
                          width: 280,
                          height: 280,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.music_note, size: 200),
                ),
              ),

              const SizedBox(height: 20),

              // 🎵 Título y artista
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    Text(
                      song.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      song.artist.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🎵 Barra de progreso
              Obx(() {
                final pos = controller.position.value;
                final dur = controller.duration.value;

                return Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.deepPurple,
                        inactiveTrackColor: Colors.grey.shade400,
                        thumbColor: Colors.deepPurple,
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: pos.inSeconds.toDouble().clamp(
                          0,
                          dur.inSeconds.toDouble(),
                        ),
                        max: dur.inSeconds.toDouble(),
                        onChanged: (value) {
                          controller.audioPlayer.seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(pos)),
                        Text(_formatDuration(dur)),
                      ],
                    ),
                  ],
                );
              }),

              const SizedBox(height: 30),

              // 🎵 Controles principales
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous, size: 40),
                      onPressed: controller.previous,
                    ),
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          size: 70,
                          color: Colors.deepPurple,
                        ),
                        onPressed: controller.togglePlayPause,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, size: 40),
                      onPressed: controller.next,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ❤️ Favoritos, 👍 Like, 📂 Playlists
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ❤️ Favorito
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          controller.isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isFavorite.value
                              ? Colors.red
                              : Colors.grey,
                          size: 32,
                        ),
                        onPressed: controller.toggleFavorite,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // 👍 Like
                    IconButton(
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.blue,
                        size: 32,
                      ),
                      onPressed: controller.likeSong,
                    ),

                    const SizedBox(width: 16),

                    // 📂 Agregar a Playlist
                    IconButton(
                      icon: const Icon(
                        Icons.playlist_add,
                        color: Colors.deepPurple,
                        size: 32,
                      ),
                      onPressed: () async {
                        await controller.loadPlaylists();
                        Get.bottomSheet(
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Agregar a Playlist",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                ...controller.playlists.map((playlist) {
                                  return ListTile(
                                    leading: const Icon(Icons.playlist_play),
                                    title: Text(playlist.name),
                                    onTap: () {
                                      controller.addSongToPlaylist(playlist.id);
                                      Get.back();
                                    },
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
