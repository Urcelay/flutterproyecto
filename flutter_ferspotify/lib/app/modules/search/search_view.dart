import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../player/player_view.dart';
import 'search_controller.dart';

/// Vista de búsqueda de canciones
class SearchsView extends GetView<SearchsController> {
  const SearchsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchsController());

    return Scaffold(
      appBar: AppBar(title: const Text("🔎 Buscar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Escribe el nombre de la canción",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      controller.query.value = val;
                      if (val.isEmpty) {
                        controller.results
                            .clear(); // 👈 Limpiamos cuando queda vacío
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controller.searchSongs,
                  child: const Text("Buscar"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Resultados
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.results.isEmpty) {
                  return FadeInDown(
                    child: const Center(
                      child: Text(
                        "Escribe algo y busca una canción 🎶",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.results.length,
                  itemBuilder: (context, index) {
                    final song = controller.results[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
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
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.play_arrow,
                            color: Colors.deepPurple,
                          ),
                          onTap: () {
                            Get.to(
                              () => PlayerView(
                                songs: controller.results,
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
            ),
          ],
        ),
      ),
    );
  }
}
