import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final String id;
  final String name;
  final String artistName;
  final String artworkUrl;
  final String genre;
  final String releaseDate;
  final String price;
  final String trackCount;
  final String albumUrl;
  final String rights;

  const Album({
    required this.id,
    required this.name,
    required this.artistName,
    required this.artworkUrl,
    required this.genre,
    required this.releaseDate,
    required this.price,
    required this.trackCount,
    required this.albumUrl,
    required this.rights,
  });

  @override
  List<Object?> get props => [id];
}
