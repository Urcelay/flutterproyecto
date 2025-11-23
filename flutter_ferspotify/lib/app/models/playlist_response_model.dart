import 'playlist_model.dart';

/// Modelo que representa la respuesta al crear una playlist.
class PlaylistResponseModel {
  final String message;
  final PlaylistModel data;

  PlaylistResponseModel({
    required this.message,
    required this.data,
  });

  /// Convierte un JSON a [PlaylistResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Lista creada exitosamente",
  ///   "data": { ... } // PlaylistModel
  /// }
  factory PlaylistResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [PlaylistResponseModel] Parseando JSON: $json");
    return PlaylistResponseModel(
      message: json['message'] ?? '',
      data: PlaylistModel.fromJson(json['data'] ?? {}),
    );
  }

  /// Convierte el objeto [PlaylistResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
      "data": data.toJson(),
    };
    print("🟡 [PlaylistResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
