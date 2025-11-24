import 'playlist_model.dart';

/// Modelo que representa la respuesta al crear una playlist.
class PlaylistResponse {
  final String message;
  final Playlist data;

  PlaylistResponse({
    required this.message,
    required this.data,
  });

  /// Convierte un JSON a [PlaylistResponse].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Lista creada exitosamente",
  ///   "data": { ... } // PlaylistModel
  /// }
  factory PlaylistResponse.fromJson(Map<String, dynamic> json) {
    print("🟢 [PlaylistResponseModel] Parseando JSON: $json");

    return PlaylistResponse(
      message: json['message'] ?? '',
      data: Playlist.fromJson(json['data'] ?? {}),
    );
  }

  /// Convierte el objeto [PlaylistResponse] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
      "data": data.toJson(),
    };
    print("🟡 [PlaylistResponse] Convirtiendo a JSON: $json");
    return json;
  }
}
