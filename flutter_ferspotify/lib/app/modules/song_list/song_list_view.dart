import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../../../app/modules/player/player_view.dart';
import 'song_list_controller.dart';

/// Vista para mostrar canciones filtradas por categoría, artista o álbum
class SongListView extends StatelessWidget {
  final String filterType; // "category", "artist", "album"
  final int filterId;

  const SongListView({
    super.key,
    required this.filterType,
    required this.filterId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SongListController());
    controller.initFilter(filterType, filterId);

    return Scaffold(
      appBar: AppBar(title: Text("Canciones por $filterType")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.songs.isEmpty) {
          return FadeInDown(
            child: const Center(
              child: Text(
                "No hay canciones disponibles 🎶",
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
              delay: Duration(milliseconds: 100 * index),
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
                  trailing: const Icon(Icons.play_arrow, color: Colors.blue),
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
