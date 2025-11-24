/// Modelo genérico para respuestas simples que solo contienen un mensaje.
class SimpleResponse {
  final String message;

  SimpleResponse({required this.message});

  /// Convierte un JSON a [SimpleResponse].
  /// Ejemplo:
  /// {
  ///   "message": "Lista eliminada correctamente"
  /// }
  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    print("🟢 [SimpleResponseModel] Parseando JSON: $json");

    return SimpleResponse(
      message: json['message'] ?? '',
    );
  }

  /// Convierte el objeto [SimpleResponse] a JSON.
  Map<String, dynamic> toJson() {
    final json = {"message": message};
    print("🟡 [SimpleResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
