import 'playlist_model.dart';
import 'song_model.dart';

/// Modelo para la respuesta de /api/lista/{id}/songs
class PlaylistSongsResponseModel {
  final Playlist lista;
  final List<Song> songs;

  PlaylistSongsResponseModel({
    required this.lista,
    required this.songs,
  });

  /// Convierte JSON a [PlaylistSongsResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "lista": {...},
  ///   "songs": [{...}, {...}]
  /// }
  factory PlaylistSongsResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [PlaylistSongsResponseModel] Parseando JSON: $json");

    return PlaylistSongsResponseModel(
      lista: Playlist.fromJson(json['lista'] ?? {}),
      songs: (json['songs'] as List<dynamic>? ?? [])
          .map((song) => Song.fromJson(song))
          .toList(),
    );
  }

  /// Convierte el objeto a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "lista": lista.toJson(),
      "songs": songs.map((s) => s.toJson()).toList(),
    };
    print("🟡 [PlaylistSongsResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
