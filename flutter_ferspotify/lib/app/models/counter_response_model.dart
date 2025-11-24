import 'song_model.dart';

/// Modelo que representa la respuesta al dar "like" a una canción.
class CounterResponse {
  final String message;
  final Song data;

  CounterResponse({
    required this.message,
    required this.data,
  });

  /// Convierte un JSON a [CounterResponse].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Like registrado",
  ///   "data": { ... } // SongModel
  /// }
  factory CounterResponse.fromJson(Map<String, dynamic> json) {
    print("🟢 [LikeResponseModel] Parseando JSON: $json");

    return CounterResponse(
      message: json['message'] ?? '',
      data: Song.fromJson(json['data'] ?? {}),
    );
  }

  /// Convierte el objeto [LikeResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
      "data": data.toJson(),
    };
    print("🟡 [LikeResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
