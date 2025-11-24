import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'searchs_controller.dart';

/// Vista del módulo de búsqueda
class SearchView extends GetView<SearchsController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🔍 Módulo de Buscar"),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: "Buscar canción...",
                border: OutlineInputBorder(),
              ),
              onChanged :controller.onSearch,
            ),
          ],
        ),
      ),
    );
  }
}
