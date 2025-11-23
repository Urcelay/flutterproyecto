import 'song_model.dart';

/// Modelo que representa la respuesta al registrar una reproducción de canción.
class PlayResponseModel {
  final String message;
  final SongModel data;

  PlayResponseModel({
    required this.message,
    required this.data,
  });

  /// Convierte un JSON a [PlayResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Reproducción registrada",
  ///   "data": { ... } // SongModel
  /// }
  factory PlayResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [PlayResponseModel] Parseando JSON: $json");
    return PlayResponseModel(
      message: json['message'] ?? '',
      data: SongModel.fromJson(json['data'] ?? {}),
    );
  }

  /// Convierte el objeto [PlayResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
      "data": data.toJson(),
    };
    print("🟡 [PlayResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
