/// Modelo que representa una categoría musical.
class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [CategoryModel] Parseando JSON: $json");
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "name": name,
    };
    print("🟡 [CategoryModel] Convirtiendo a JSON: $json");
    return json;
  }
}
