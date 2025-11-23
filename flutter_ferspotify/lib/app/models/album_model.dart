/// Modelo que representa a un álbum.
class AlbumModel {
  final int id;
  final String name;

  AlbumModel({required this.id, required this.name});

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [AlbumModel] Parseando JSON: $json");
    return AlbumModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final json = {"id": id, "name": name};
    print("🟡 [AlbumModel] Convirtiendo a JSON: $json");
    return json;
  }
}
