/// Modelo que representa una playlist.
class Playlist {
  final int id;
  final int idUser;
  final String name;
  final bool isPublic;
  final String createdAt;
  final String updatedAt;

  Playlist({
    required this.id,
    required this.idUser,
    required this.name,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convierte un JSON a [Playlist].
  /// Ejemplo de JSON:
  /// {
  ///   "id_user": 2,
  ///   "name": "Gym Power Playlist",
  ///   "is_public": true,
  ///   "created_at": "...",
  ///   "updated_at": "...",
  ///   "id": 59
  /// }
  factory Playlist.fromJson(Map<String, dynamic> json) {
    print("🟢 [PlaylistModel] Parseando JSON: $json");

    return Playlist(
      id: json['id'] ?? 0,
      idUser: json['id_user'] ?? 0,
      name: json['name'] ?? '',
      isPublic: json['is_public'] == 1 || json['is_public'] == true,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  /// Convierte el objeto [Playlist] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "id_user": idUser,
      "name": name,
      "is_public": isPublic ? 1 : 0,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
    print("🟡 [Playlist] Convirtiendo a JSON: $json");
    return json;
  }
}
