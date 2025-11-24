import 'user_model.dart';

/// Modelo que representa la respuesta completa del endpoint /api/login.
/// Contiene el mensaje, el token de acceso y los datos del usuario autenticado.
class AuthResponseModel {
  final String message;
  final String token;
  final UserModel user;

  AuthResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  /// Convierte un JSON a una instancia de [AuthResponseModel].
  /// Ejemplo de JSON:
  /// {
  ///   "message": "Usuario registrado correctamente",
  ///   "token": "48|4QqRtXrmBHiqtCPI10HGR7EknivrtJKtYoOah9fIa5739128",
  ///   "user": { ... }
  /// }
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [AuthResponseModel] Parseando JSON de autenticación: $json");

    return AuthResponseModel(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  /// Convierte un objeto [AuthResponseModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "message": message,
      "token": token,
      "user": user.toJson(),
    };
    print("🟡 [AuthResponseModel] Convirtiendo a JSON: $json");
    return json;
  }
}
