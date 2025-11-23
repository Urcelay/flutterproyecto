import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constans.dart';
import '../models/playlist_response_model.dart';
import "../models/playlist_model.dart";
import "../models/simple_response_model.dart";

/// Proveedor para manejar playlists.
/// Incluye métodos para crear, editar, eliminar y listar.
class PlaylistProvider {
  /// Crear una nueva playlist.
  /// Requiere autenticación con [token].
  static Future<PlaylistResponseModel?> createPlaylist(
    String token,
    String name,
    bool isPublic,
  ) async {
    final url = Uri.parse('$BASE_URL/lista/create');
    print("🔵 [PlaylistProvider] POST $url");
    print("📝 [PlaylistProvider] Body enviado: {name: $name, is_public: $isPublic}");
    print("🟦 [PlaylistProvider] Token enviado: Bearer $token");

    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "name": name,
          "is_public": isPublic.toString(),
        },
      );

        print("🟡 [PlaylistProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [PlaylistProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [PlaylistProvider] Playlist creada exitosamente.");
      return PlaylistResponseModel.fromJson(data);
    } else {
      print("🔴 [PlaylistProvider] Error en createPlaylist: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [PlaylistProvider] Excepción capturada en createPlaylist: $e");
    return null;
  }
}




/// Obtener todas las playlists de un usuario por su [userId].
/// No requiere autenticación (dependiendo del backend, si es público).
static Future<List<PlaylistModel>> getUserPlaylists(int userId) async {
  final url = Uri.parse('$BASE_URL/lista/$userId');
  print("🔵 [PlaylistProvider] GET $url");

  try {
    final response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    print("🟡 [PlaylistProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [PlaylistProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("🟢 [PlaylistProvider] Playlists obtenidas: ${data.length}");
      return data
          .map((playlist) => PlaylistModel.fromJson(playlist))
          .toList();
    } else {
      print("🔴 [PlaylistProvider] Error en getUserPlaylists: ${response.body}");
      return [];
    }
  } catch (e) {
    print("🚨 [PlaylistProvider] Excepción capturada en getUserPlaylists: $e");
    return [];
  }
}

/// Editar una playlist existente.
/// Requiere autenticación.
static Future<PlaylistResponseModel?> updatePlaylist(
  String token,
  int playlistId,
  String name,
  bool isPublic,
) async {
  final url = Uri.parse('$BASE_URL/lista/$playlistId/edit');
  print("🔵 [PlaylistProvider] PUT $url");
  print("📝 [PlaylistProvider] Body enviado: {name: $name, is_public: $isPublic}");
  print("🟦 [PlaylistProvider] Token enviado: Bearer $token");

  try {
    final response = await http.put(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {
        "name": name,
        "is_public": isPublic.toString(),
      },
    );

    print("🟡 [PlaylistProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [PlaylistProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [PlaylistProvider] Playlist editada exitosamente.");
      return PlaylistResponseModel.fromJson(data);
    } else {
      print("🔴 [PlaylistProvider] Error en editPlaylist: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [PlaylistProvider] Excepción capturada en editPlaylist: $e");
    return null;
  }
}

/// Eliminar una playlist por su [playlistId].
/// Requiere autenticación.
/// Devuelve un [SimpleResponseModel] con el mensaje de éxito o error.
static Future<SimpleResponseModel?> deletePlaylist(
  String token,
  int playlistId,
) async {
  final url = Uri.parse('$BASE_URL/lista/$playlistId/delete');
  print("🔵 [PlaylistProvider] DELETE $url");
  print("🟦 [PlaylistProvider] Token enviado: Bearer $token");

  try {
    final response = await http.delete(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [PlaylistProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [PlaylistProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [PlaylistProvider] Playlist eliminada correctamente.");
      return SimpleResponseModel.fromJson(data);
    } else {
      print("🔴 [PlaylistProvider] Error en deletePlaylist: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [PlaylistProvider] Excepción capturada en deletePlaylist: $e");
    return null;
  }
}



}
