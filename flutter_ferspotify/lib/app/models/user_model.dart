/// Modelo que representa un usuario en el sistema.
/// Este modelo se usará para mapear la respuesta JSON
/// del backend cuando se realicen operaciones de autenticación u otros endpoints.
class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  /// Convierte un JSON a una instancia de [UserModel].
  /// Ejemplo de JSON:
  /// {
  ///   "id": 2,
  ///   "name": "Juan",
  ///   "email": "juan@email.com"
  /// }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [UserModel] Parseando JSON del usuario: $json");

    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  /// Convierte un objeto [UserModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "name": name,
      "email": email,
    };
    print("🟡 [UserModel] Convirtiendo a JSON: $json");
    return json;
  }
}


