import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constans.dart';

import '../models/song_model.dart';
import '../models/favorite_response_model.dart';
import '../models/counter_response_model.dart';

/// Proveedor para manejar la música.
/// Incluye métodos para listar, filtrar, buscar y reproducir canciones.
class MusicProvider {
  /// Método para filtrar canciones por categoría, artista o álbum.
  /// Todos los parámetros son opcionales.
  /// Endpoint: GET /api/music/filter
  static Future<List<Song>> getSong({
    int? category,
    int? artist,
    int? album,
  }) async {
    final url = Uri.parse('$BASE_URL/music/filter').replace(
      queryParameters: {
        if (category != null) "category": category.toString(),
        if (artist != null) "artist": artist.toString(),
        if (album != null) "album": album.toString(),
      },
    );

    print("🔵 [MusicProvider] GET $url");

    try {
      final response = await http.get(
        url,
        headers: {"Accept": "application/json"},
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(
          "🟢 [MusicProvider] Parseando lista de canciones (${data.length})...",
        );
        return data.map((song) => Song.fromJson(song)).toList();
      } else {
        print("🔴 [MusicProvider] Error en filterSongs: ${response.body}");
        return [];
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en filterSongs: $e");
      return [];
    }
  }

  /// Obtener las canciones favoritas del usuario autenticado.
  /// Se debe enviar el [token] en los headers.
  static Future<List<Song>> getFavorites(String token) async {
    final url = Uri.parse('$BASE_URL/favorites');
    print("🔵 [MusicProvider] GET $url");
    print("📤 [MusicProvider] Token enviado: Bearer $token");

    try {
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("🟢 [MusicProvider] Favoritos obtenidos: ${data.length}");
        return data.map((song) => Song.fromJson(song)).toList();
      } else {
        print("🔴 [MusicProvider] Error en getFavorites: ${response.body}");
        return [];
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en getFavorites: $e");
      return [];
    }
  }

  /// Agregar o quitar una canción de favoritos (toggle).
  /// Se debe enviar el [token] y el [musicId].
  /// Endpoint: POST /api/music/{id}/favorite
  static Future<FavoriteResponseModel?> toggleFavorite(
    String token,
    int musicId,
  ) async {
    final url = Uri.parse('$BASE_URL/music/$musicId/favorite');
    print("🔵 [MusicProvider] POST $url");
    print("📤 [MusicProvider] Token enviado: Bearer $token");

    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("🟢 [MusicProvider] Favorito actualizado con éxito.");
        return FavoriteResponseModel.fromJson(data);
      } else {
        print("🔴 [MusicProvider] Error en toggleFavorite: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en toggleFavorite: $e");
      return null;
    }
  }

  /// Obtener el Top 10 de canciones más reproducidas.
  /// No requiere autenticación.
  /// Endpoint: GET /api/music/top
  static Future<List<Song>> getTopSongs() async {
    final url = Uri.parse('$BASE_URL/music/top');
    print("🔵 [MusicProvider] GET $url");

    try {
      final response = await http.get(
        url,
        headers: {"Accept": "application/json"},
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("🟢 [MusicProvider] Top canciones obtenidas: ${data.length}");
        return data.map((song) => Song.fromJson(song)).toList();
      } else {
        print("🔴 [MusicProvider] Error en getTopSongs: ${response.body}");
        return [];
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en getTopSongs: $e");
      return [];
    }
  }

  /// Buscar canciones por título.
  /// No requiere autenticación.
  /// Endpoint: GET /api/music/search?query=texto
  static Future<List<Song>> searchSongs(String query) async {
    final url = Uri.parse(
      '$BASE_URL/music/search',
    ).replace(queryParameters: {"query": query});

    print("🔵 [MusicProvider] GET $url");
    print("📤 [MusicProvider] Parámetro enviado: query=$query");

    try {
      final response = await http.get(
        url,
        headers: {"Accept": "application/json"},
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("🟢 [MusicProvider] Canciones encontradas: ${data.length}");
        return data.map((song) => Song.fromJson(song)).toList();
      } else {
        print("🔴 [MusicProvider] Error en searchSongs: ${response.body}");
        return [];
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en searchSongs: $e");
      return [];
    }
  }

  /// Obtener el detalle de una canción por ID.
  /// No requiere autenticación.
  /// Endpoint: GET /api/music/{id}
  static Future<Song?> getSongByID(int id) async {
    final url = Uri.parse('$BASE_URL/music/$id');
    print("🔵 [MusicProvider] GET $url");

    try {
      final response = await http.get(
        url,
        headers: {"Accept": "application/json"},
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("🟢 [MusicProvider] Canción obtenida correctamente.");
        return Song.fromJson(data);
      } else {
        print("🔴 [MusicProvider] Error en getSongByID: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en getSongByID: $e");
      return null;
    }
  }

  /// Dar "like" a una canción.
  /// No requiere autenticación.
  /// Endpoint: POST /api/music/like/{id}
  static Future<CounterResponse?> likeSong(int musicId) async {
    final url = Uri.parse('$BASE_URL/music/like/$musicId');
    print("🔵 [MusicProvider] POST $url");

    try {
      final response = await http.post(
        url,
        headers: {"Accept": "application/json"},
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("🟢 [MusicProvider] Like registrado correctamente.");
        return CounterResponse.fromJson(data);
      } else {
        print("🔴 [MusicProvider] Error en likeSong: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en likeSong: $e");
      return null;
    }
  }

  /// Registrar la reproducción de una canción.
  /// No requiere autenticación.
  /// Endpoint: POST /api/music/play/{id}
  static Future<CounterResponse?> playSong(int musicId) async {
    final url = Uri.parse('$BASE_URL/music/play/$musicId');
    print("🔵 [MusicProvider] POST $url");

    try {
      final response = await http.post(
        url,
        headers: {"Accept": "application/json"},
      );

      print("🟡 [MusicProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [MusicProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("🟢 [MusicProvider] Reproducción registrada correctamente.");
        return CounterResponse.fromJson(data);
      } else {
        print("🔴 [MusicProvider] Error en playSong: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 [MusicProvider] Excepción capturada en playSong: $e");
      return null;
    }
  }

}
