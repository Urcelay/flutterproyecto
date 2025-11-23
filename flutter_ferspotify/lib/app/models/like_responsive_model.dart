import 'song_model.dart';

/// Modelo que representa la respuesta al dar "like" a una canción.
class LikeResponseModel {
  final String message;
  final SongModel data;

  LikeResponseModel({
    required this.message,
    required this.data,
  });

  /// Convierte un JSON a [LikeResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Like registrado",
  ///   "data": { ... } // SongModel
  /// }
  factory LikeResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [LikeResponseModel] Parseando JSON: $json");
    return LikeResponseModel(
      message: json['message'] ?? '',
      data: SongModel.fromJson(json['data'] ?? {}),
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
