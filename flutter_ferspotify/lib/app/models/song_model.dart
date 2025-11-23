import 'artist_model.dart';
import 'album_model.dart';
import 'category_model.dart';

/// Modelo que representa una canción.
/// Se usa tanto para el listado general como para favoritos.
class SongModel {
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

  /// Nuevos campos
  final int? size;
  final String? fileName;
  final String? createdAt;
  final String? updatedAt;

  /// Relaciones (pueden ser null)
  final ArtistModel? artist;
  final AlbumModel? album;
  final CategoryModel? category;

  SongModel({
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
    this.artist,
    this.album,
    this.category,
  });

  /// Convierte un JSON a [SongModel].
  factory SongModel.fromJson(Map<String, dynamic> json) {
    print("🟢 [SongModel] Parseando JSON: $json");

    return SongModel(
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

      size: json['size'],
      fileName: json['file_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],

      /// Asegura que sea un mapa antes de parsear
      artist: json['artist'] is Map<String, dynamic>
          ? ArtistModel.fromJson(json['artist'])
          : null,

      album: json['album'] is Map<String, dynamic>
          ? AlbumModel.fromJson(json['album'])
          : null,

      category: json['category'] is Map<String, dynamic>
          ? CategoryModel.fromJson(json['category'])
          : null,
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
