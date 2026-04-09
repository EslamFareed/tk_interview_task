import 'package:tk_interview_task/data/datasources/itunes_remote_datasource.dart';
import 'package:tk_interview_task/domain/entities/album.dart';
import 'package:tk_interview_task/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final ItunesRemoteDatasource remoteDatasource;

  const AlbumRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Album>> getTopAlbums() async {
    return remoteDatasource.getTopAlbums();
  }
}
