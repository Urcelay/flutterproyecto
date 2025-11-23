/// Modelo que representa la respuesta del endpoint /api/logout.
/// Solo contiene un mensaje de confirmación.
class LogoutResponseModel {
  final String message;

  LogoutResponseModel({required this.message});

  /// Convierte un JSON a una instancia de [LogoutResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Sesión cerrada correctamente"
  /// }
  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [LogoutResponseModel] Parseando JSON de logout: $json");
    return LogoutResponseModel(message: json['message'] ?? '');
  }

  /// Convierte un objeto [LogoutResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {"message": message};
    print("🟡 [LogoutResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
