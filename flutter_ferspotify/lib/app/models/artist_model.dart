/// Modelo que representa a un artista.
class ArtistModel {
  final int id;
  final String name;

  ArtistModel({required this.id, required this.name});

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [ArtistModel] Parseando JSON: $json");
    return ArtistModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final json = {"id": id, "name": name};
    print("🟡 [ArtistModel] Convirtiendo a JSON: $json");
    return json;
  }
}
