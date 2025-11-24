import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'playlists_controller.dart';

import '../favorites/favorites_view.dart';
import '../playlists/playlists_view.dart';
import '../search/search_view.dart';

/// Vista del módulo de playlists
class PlaylistView extends GetView<PlaylistController> {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("🎵 Módulo de Playlists"),
      ),
    );
  }
}
