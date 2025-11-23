/// Modelo que representa la respuesta al agregar o quitar una canción de favoritos.
class FavoriteResponseModel {
  final String message;
  final Map<String, dynamic> data;

  FavoriteResponseModel({
    required this.message,
    required this.data,
  });

  /// Convierte un JSON a [FavoriteResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Canción agregada a favoritos",
  ///   "data": {
  ///     "user_id": 2,
  ///     "music_id": "5",
  ///     "updated_at": "2025-09-13T02:19:32.000000Z",
  ///     "created_at": "2025-09-13T02:19:32.000000Z",
  ///     "id": 112
  ///   }
  /// }
  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [FavoriteResponseModel] Parseando JSON: $json");
    return FavoriteResponseModel(
      message: json['message'] ?? '',
      data: (json['data'] as Map<String, dynamic>? ?? {}),
    );
  }

  /// Convierte el objeto [FavoriteResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
      "data": data,
    };
    print("🟡 [FavoriteResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
