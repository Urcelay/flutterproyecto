import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../favorites/favorites_view.dart';
import '../playlists/playlists_view.dart';
import '../search/search_view.dart';
import '../song_list/song_list_view.dart';
import 'home_controller.dart';

/// Vista principal con BottomNavigationBar
/// Tab 0 = Home con categorías, artistas y álbumes
/// Tab 1 = Buscar
/// Tab 2 = Favoritos
/// Tab 3 = Listas
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: const Text("AnderMusicfy")),
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            _buildHomeTab(), // Tab Home
            const SearchView(), // Tab Buscar
            const FavoritesView(), // Tab Favoritos
            const PlaylistView(), // Tab Listas
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
            BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: "Listas"),
          ],
        ),
      );
    });
  }

  /// Construcción del Tab Home con carruseles de categorías, artistas y álbumes
  Widget _buildHomeTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              "Categorías",
              controller.categories
                  .map((c) => {"id": c.id, "name": c.name})
                  .toList(),
              "category",
            ),
            _buildSection(
              "Artistas",
              controller.artists
                  .map((a) => {"id": a.id, "name": a.name})
                  .toList(),
              "artist",
            ),
            _buildSection(
              "Álbumes",
              controller.albums
                  .map((al) => {"id": al.id, "name": al.name})
                  .toList(),
              "album",
            ),
          ],
        ),
      );
    });
  }

  /// Construir sección horizontal (categorías/artistas/álbumes)
  Widget _buildSection(
    String title,
    List<Map<String, dynamic>> items,
    String filterType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => SongListView(
                      filterType: filterType,
                      filterId: item["id"],
                      filterName: item["name"],
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item["name"],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
