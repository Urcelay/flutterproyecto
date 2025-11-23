/// Modelo que representa una playlist.
class PlaylistModel {
  final int id;
  final int idUser;
  final String name;
  final bool isPublic;
  final String createdAt;
  final String updatedAt;

  PlaylistModel({
    required this.id,
    required this.idUser,
    required this.name,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convierte un JSON a [PlaylistModel].
  /// Ejemplo de JSON:
  /// {
  ///   "id_user": 2,
  ///   "name": "Gym Power Playlist",
  ///   "is_public": true,
  ///   "created_at": "2025-09-13T02:19:32.000000Z",
  ///   "updated_at": "2025-09-13T02:19:32.000000Z"
  ///   "id": 59
  /// }
  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [PlaylistModel] Parseando JSON: $json");
    return PlaylistModel(
      id: json['id'] ?? 0,
      idUser: json['id_user'] ?? 0,
      name: json['name'] ?? '',
      isPublic: json['is_public'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  /// Convierte el objeto [PlaylistModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "id_user": idUser,
      "name": name,
      "is_public": isPublic,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
    print("🟡 [PlaylistModel] Convirtiendo a JSON: $json");
    return json;
  }
}
