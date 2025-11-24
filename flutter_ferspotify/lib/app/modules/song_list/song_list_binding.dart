import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/song_model.dart';
import '../../providers/music_provider.dart';

/// Vista para mostrar canciones filtradas por categoría, artista o álbum
class SongListView extends StatefulWidget {
  final String filterType; // "category", "artist", "album"
  final int filterId;
  final String filterName;

  const SongListView({
    super.key,
    required this.filterType,
    required this.filterId,
    required this.filterName,
  });

  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {
  List<SongModel> songs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    try {
      final data = await MusicProvider.getSong();
      if (data != null) {
        setState(() {
          songs = data.where((s) {
            if (widget.filterType == "category") {
              return s.category?.id == widget.filterId;
            } else if (widget.filterType == "artist") {
              return s.artist?.id == widget.filterId;
            } else if (widget.filterType == "album") {
              return s.album?.id == widget.filterId;
            }
            return false;
          }).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error al obtener canciones: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("🎵 ${widget.filterName}"),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (_, index) {
          final song = songs[index];
          return ListTile(
            leading: Image.network(
              song.coverImage ?? "",
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(song.title ?? ""),
            subtitle: Text(
              "${song.artist?.name ?? ''} - ${song.album?.name ?? ''}",
            ),
            trailing: const Icon(Icons.play_arrow),
            onTap: () {
              // Aquí luego conectaremos con PlayerView
            },
          );
        },
      ),
    );
  }
}
