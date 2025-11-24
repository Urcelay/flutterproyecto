import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../player/player_view.dart';
import 'favorites_controller.dart';

/// Vista de Favoritos: muestra las canciones favoritas del usuario
class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(title: const Text("❤️ Favoritos")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favorites.isEmpty) {
          return FadeInDown(
            child: const Center(
              child: Text(
                "No tienes canciones favoritas todavía 🎶",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        // 👉 RefreshIndicator para recargar con pull
        return RefreshIndicator(
          onRefresh: controller.loadFavorites,
          child: ListView.builder(
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              final song = controller.favorites[index];
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          : const Icon(
                              Icons.favorite,
                              size: 40,
                              color: Colors.red,
                            ),
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
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {
                            Get.to(
                              () => PlayerView(
                                songs: controller.favorites,
                                startIndex: index,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              controller.removeFromFavorites(song.id),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
