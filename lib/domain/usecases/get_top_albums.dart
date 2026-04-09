import 'package:tk_interview_task/domain/entities/album.dart';
import 'package:tk_interview_task/domain/repositories/album_repository.dart';

class GetTopAlbums {
  final AlbumRepository repository;

  const GetTopAlbums(this.repository);

  Future<List<Album>> call() => repository.getTopAlbums();
}
