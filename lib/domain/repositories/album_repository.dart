import 'package:tk_interview_task/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getTopAlbums();
}
