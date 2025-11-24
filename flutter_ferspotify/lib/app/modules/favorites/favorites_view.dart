import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorites_controller.dart';

/// Vista del módulo de favoritos
class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("⭐ Módulo de Favoritos"),
      ),
    );
  }
}
