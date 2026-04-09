import 'package:tk_interview_task/domain/entities/album.dart';

class AlbumModel extends Album {
  const AlbumModel({
    required super.id,
    required super.name,
    required super.artistName,
    required super.artworkUrl,
    required super.genre,
    required super.releaseDate,
    required super.price,
    required super.trackCount,
    required super.albumUrl,
    required super.rights,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final images = json['im:image'] as List<dynamic>;
    final artworkUrl = images.isNotEmpty
        ? (images.last['label'] as String)
        : '';

    return AlbumModel(
      id: json['id']['attributes']['im:id'] as String,
      name: json['im:name']['label'] as String,
      artistName: json['im:artist']['label'] as String,
      artworkUrl: artworkUrl,
      genre: json['category']['attributes']['label'] as String,
      releaseDate: json['im:releaseDate']['attributes']['label'] as String,
      price: json['im:price']['label'] as String,
      trackCount: json['im:itemCount']['label'] as String,
      albumUrl: json['link']['attributes']['href'] as String,
      rights: json['rights']['label'] as String,
    );
  }
}
