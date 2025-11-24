import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../search/search_view.dart';
import '../favorites/favorites_view.dart';
import '../playlists/playlist_view.dart';
import '../song_list/song_list_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Categorías",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Categorías
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return FadeInLeft(
                      delay: Duration(milliseconds: 100 * index),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => SongListView(
                            filterType: "category",
                            filterId: category.id,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Container(
                            width: 140,
                            alignment: Alignment.center,
                            child: Text(
                              category.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Artistas
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Artistas",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.artists.length,
                  itemBuilder: (context, index) {
                    final artist = controller.artists[index];
                    return FadeInRight(
                      delay: Duration(milliseconds: 100 * index),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => SongListView(
                            filterType: "artist",
                            filterId: artist.id,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Container(
                            width: 140,
                            alignment: Alignment.center,
                            child: Text(
                              artist.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Álbumes
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Álbumes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.albums.length,
                  itemBuilder: (context, index) {
                    final album = controller.albums[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => SongListView(
                            filterType: "album",
                            filterId: album.id,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Container(
                            width: 140,
                            alignment: Alignment.center,
                            child: Text(
                              album.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      const SearchsView(),
      const FavoritesView(),
      const PlaylistView(),
    ];

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: const Text("🎵 AnderMusicfy"),
          ),
          actions: [
            // Botón cambiar tema
            FadeInRight(
              duration: const Duration(milliseconds: 500),
              child: IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  );
                },
              ),
            ),
            // Botón logout
            FadeInRight(
              duration: const Duration(milliseconds: 700),
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // Aquí implementaremos logout real con AuthStorage
                  Get.snackbar("Logout", "Sesión cerrada correctamente");
                  Get.offAllNamed("/login");
                },
              ),
            ),
          ],
        ),
        body: tabs[controller.currentIndex.value],
        bottomNavigationBar: FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Buscar",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favoritos",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_play),
                label: "Listas",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
