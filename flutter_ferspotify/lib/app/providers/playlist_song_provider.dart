import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constans.dart';
import '../models/simple_response_model.dart';
import '../models/playlist_songs_response_model.dart';


/// Proveedor para manejar las canciones dentro de una playlist.
/// Incluye métodos para agregar, quitar y listar canciones.
class PlaylistSongProvider {
  /// Agregar canciones a una playlist existente.
  /// Requiere autenticación.
  ///
  /// [playlistId] es el ID de la playlist.
  /// [musicIds] es la lista de IDs de canciones a agregar.
  /// Devuelve un [SimpleResponseModel] con el mensaje de confirmación.
static Future<SimpleResponseModel?> addSongsToPlaylist(
    String token,
    int playlistId,
    List<int> musicIds,
  ) async {
    final url = Uri.parse('$BASE_URL/lista/$playlistId/add');
    print("🔵 [PlaylistSongProvider] POST $url");
    print("📝 [PlaylistSongProvider] Body enviado: {music_ids: $musicIds}");
    print("🟦 [PlaylistSongProvider] Token enviado: Bearer $token");

    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          // Ajusta la clave según lo que espere tu API, por ejemplo "music_id[]"
          "music_ids": musicIds.join(','), 
        },
      );

      print("🟡 [PlaylistSongProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [PlaylistSongProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("🟢 [PlaylistSongProvider] Canciones agregadas correctamente.");
        return SimpleResponseModel.fromJson(data);
      } else {
        print("🔴 [PlaylistSongProvider] Error en addSongsToPlaylist: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 [PlaylistSongProvider] Excepción capturada en addSongsToPlaylist: $e");
      return null;
    }
  }

/// Obtener el detalle de una playlist con todas sus canciones.
/// Requiere autenticación.
static Future<PlaylistSongsResponseModel?> getPlaylistSongs(
  String token,
  int playlistId,
) async {
  final url = Uri.parse('$BASE_URL/lista/$playlistId/songs');
  print("🔵 [PlaylistSongProvider] GET $url");
  print("🟦 [PlaylistSongProvider] Token enviado: Bearer $token");

  try {
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [PlaylistSongProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [PlaylistSongProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [PlaylistSongProvider] Playlist obtenida correctamente.");
      return PlaylistSongsResponseModel.fromJson(data);
    } else {
      print("🔴 [PlaylistSongProvider] Error en getPlaylistSongs: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [PlaylistSongProvider] Excepción capturada en getPlaylistSongs: $e");
    return null;
  }
}


/// Eliminar una canción de una playlist.
/// Requiere autenticación.
/// [playlistId] = ID de la playlist
/// [musicId] = ID de la canción a quitar.
/// Devuelve un [SimpleResponseModel] con el mensaje de confirmación.
static Future<SimpleResponseModel?> removeSongFromPlaylist(
  String token,
  int playlistId,
  int musicId,
) async {
  final url = Uri.parse('$BASE_URL/lista/$playlistId/remove/$musicId');
  print("🔵 [PlaylistSongProvider] DELETE $url");
  print("🟦 [PlaylistSongProvider] Token enviado: Bearer $token");

  try {
    final response = await http.delete(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [PlaylistSongProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [PlaylistSongProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [PlaylistSongProvider] Canción eliminada de la playlist correctamente.");
      return SimpleResponseModel.fromJson(data);
    } else {
      print("🔴 [PlaylistSongProvider] Error en removeSongFromPlaylist: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [PlaylistSongProvider] Excepción capturada en removeSongFromPlaylist: $e");
    return null;
  }
}


}
