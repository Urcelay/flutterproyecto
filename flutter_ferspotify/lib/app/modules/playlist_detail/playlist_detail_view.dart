import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../player/player_view.dart';
import 'playlist_detail_controller.dart';

/// Vista del detalle de una playlist
class PlaylistDetailView extends StatelessWidget {
  final int playlistId;

  const PlaylistDetailView({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlaylistDetailController());
    controller.init(playlistId);

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.playlist.value?.name ?? "Playlist 🎵"),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.songs.isEmpty) {
          return FadeInDown(
            child: const Center(
              child: Text(
                "No hay canciones en esta playlist 📭",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.songs.length,
          itemBuilder: (context, index) {
            final song = controller.songs[index];
            return FadeInUp(
              delay: Duration(milliseconds: 80 * index),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: song.coverImage != null
                        ? Image.network(
                            song.coverImage!,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.music_note, size: 40),
                  ),
                  title: Text(
                    song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "${song.artist.name} • ${song.album.name}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Eliminar Canción",
                        middleText:
                            "¿Seguro que deseas quitar esta canción de la playlist?",
                        textConfirm: "Eliminar",
                        textCancel: "Cancelar",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          controller.removeSong(song.id);
                          Get.back();
                        },
                      );
                    },
                  ),
                  onTap: () {
                    Get.to(
                      () => PlayerView(
                        songs: controller.songs,
                        startIndex: index,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
