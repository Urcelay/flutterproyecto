/// Modelo simple para respuestas que solo contienen un mensaje.
class SimpleResponseModel {
  final String message;

  SimpleResponseModel({required this.message});

  /// Convierte un JSON a [SimpleResponseModel].
  /// Ejemplo:
  /// {
  ///   "message": "Lista eliminada correctamente"
  /// }
  factory SimpleResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [SimpleResponseModel] Parseando JSON: $json");
    return SimpleResponseModel(
      message: json['message'] ?? '',
    );
  }

  /// Convierte el objeto [SimpleResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
    };
    print("🟡 [SimpleResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
