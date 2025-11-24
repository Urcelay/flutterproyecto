/// Modelo que representa una canción.
/// Se usa tanto para el listado general como para favoritos.
class Song {
  final int id;
  final String title;
  final String fileUrl;
  final String coverImage;
  final String duration;
  final int playCount;
  final int likes;
  final int isFeatured;
  final int idCategory;
  final int idArtist;
  final int idAlbum;

  // Nuevos campos (pueden ser null en algunos endpoints)
  final int? size;
  final String? fileName;
  final String? createdAt;
  final String? updatedAt;

  final Pivot? pivot;

  final Artist artist;
  final Album album;
  final Category category;

  Song({
    required this.id,
    required this.title,
    required this.fileUrl,
    required this.coverImage,
    required this.duration,
    required this.playCount,
    required this.likes,
    required this.isFeatured,
    required this.idCategory,
    required this.idArtist,
    required this.idAlbum,
    this.size,
    this.fileName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    required this.artist,
    required this.album,
    required this.category,
  });

  /// Convierte un JSON a [SongModel].
  factory Song.fromJson(Map<String, dynamic> json) {
    print("🟢 [SongModel] Parseando JSON: $json");

    return Song(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      fileUrl: json['file_url'] ?? '',
      coverImage: json['cover_image'] ?? '',
      duration: json['duration'] ?? '',
      playCount: json['play_count'] ?? 0,
      likes: json['likes'] ?? 0,
      isFeatured: json['is_featured'] ?? 0,
      idCategory: json['id_category'] ?? 0,
      idArtist: json['id_artist'] ?? 0,
      idAlbum: json['id_album'] ?? 0,
      size: json['size'], // puede venir null
      fileName: json['file_name'], // puede venir null
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      artist: Artist.fromJson(json['artist'] ?? {}),
      album: Album.fromJson(json['album'] ?? {}),
      category: Category.fromJson(json['category'] ?? {}),
    );
  }

  /// Convierte el objeto [SongModel] a JSON.
  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "title": title,
      "file_url": fileUrl,
      "cover_image": coverImage,
      "duration": duration,
      "play_count": playCount,
      "likes": likes,
      "is_featured": isFeatured,
      "id_category": idCategory,
      "id_artist": idArtist,
      "id_album": idAlbum,
      "size": size,
      "file_name": fileName,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "artist": artist?.toJson(),
      "album": album?.toJson(),
      "category": category?.toJson(),
    };
    print("🟡 [SongModel] Convirtiendo a JSON: $json");
    return json;
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    print("🟢 [CategoryModel] Parseando JSON: $json");

    return Category(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final json = {"id": id, "name": name};
    print("🟡 [CategoryModel] Convirtiendo a JSON: $json");
    return json;
  }
}

class Album {
  final int id;
  final String name;

  Album({required this.id, required this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    print("🟢 [AlbumModel] Parseando JSON: $json");

    return Album(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final json = {"id": id, "name": name};
    print("🟡 [AlbumModel] Convirtiendo a JSON: $json");
    return json;
  }
}

class Artist {
  final int id;
  final String name;

  Artist({required this.id, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    print("🟢 [ArtistModel] Parseando JSON: $json");

    return Artist(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final json = {"id": id, "name": name};
    print("🟡 [ArtistModel] Convirtiendo a JSON: $json");
    return json;
  }
}

class Pivot {
  final int idlista;
  final int idMusic;
  final int order;
  final String? createdAt;
  final String? updatedAt;

  Pivot({
    required this.idlista,
    required this.idMusic,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    print("🟢 [ArtistModel] Parseando JSON: $json");

    return Pivot(
      idlista: json['id_lista'] ?? 0,
      idMusic: json['id_music'] ?? 0,
      order: json['order'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
