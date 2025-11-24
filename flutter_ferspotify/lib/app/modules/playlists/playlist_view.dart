import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../../../app/modules/playlist_detail/playlist_detail_view.dart';
import 'playlist_controller.dart';

/// Vista de Playlists del usuario autenticado
class PlaylistView extends GetView<PlaylistController> {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlaylistController());

    return Scaffold(
      appBar: AppBar(title: const Text("🎶 Mis Playlists")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showCreateDialog(controller);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.playlists.isEmpty) {
          return FadeInDown(
            child: const Center(
              child: Text(
                "No tienes playlists creadas 📂",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.playlists.length,
          itemBuilder: (context, index) {
            final playlist = controller.playlists[index];
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.playlist_play,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    playlist.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    playlist.isPublic ? "🌍 Pública" : "🔒 Privada",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showEditDialog(
                            controller,
                            playlist.id,
                            playlist.name,
                            playlist.isPublic,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteDialog(controller, playlist.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => PlaylistDetailView(playlistId: playlist.id));
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  /// Mostrar diálogo para crear playlist
  void _showCreateDialog(PlaylistController controller) {
    final nameController = TextEditingController();
    var isPublic = true.obs;

    Get.defaultDialog(
      title: "Nueva Playlist",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Nombre de la playlist",
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SwitchListTile(
              title: const Text("¿Pública?"),
              value: isPublic.value,
              onChanged: (val) => isPublic.value = val,
            ),
          ),
        ],
      ),
      textConfirm: "Crear",
      textCancel: "Cancelar",
      onConfirm: () {
        if (nameController.text.isNotEmpty) {
          controller.createPlaylist(nameController.text, isPublic.value);
          Get.back();
        }
      },
    );
  }

  /// Mostrar diálogo para editar playlist
  void _showEditDialog(
    PlaylistController controller,
    int id,
    String currentName,
    bool currentPublic,
  ) {
    final nameController = TextEditingController(text: currentName);
    var isPublic = currentPublic.obs;

    Get.defaultDialog(
      title: "Editar Playlist",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Nombre de la playlist",
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SwitchListTile(
              title: const Text("¿Pública?"),
              value: isPublic.value,
              onChanged: (val) => isPublic.value = val,
            ),
          ),
        ],
      ),
      textConfirm: "Guardar",
      textCancel: "Cancelar",
      onConfirm: () {
        if (nameController.text.isNotEmpty) {
          controller.updatePlaylist(id, nameController.text, isPublic.value);
          Get.back();
        }
      },
    );
  }

  /// Mostrar diálogo de confirmación para eliminar playlist
  void _showDeleteDialog(PlaylistController controller, int id) {
    Get.defaultDialog(
      title: "Eliminar Playlist",
      middleText: "¿Seguro que deseas eliminar esta playlist? 🎧",
      textConfirm: "Eliminar",
      textCancel: "Cancelar",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deletePlaylist(id);
        Get.back();
      },
    );
  }
}
