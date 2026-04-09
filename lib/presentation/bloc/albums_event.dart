part of 'albums_bloc.dart';

abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAlbums extends AlbumsEvent {
  const FetchAlbums();
}
