part of 'albums_bloc.dart';

abstract class AlbumsState extends Equatable {
  const AlbumsState();

  @override
  List<Object?> get props => [];
}

class AlbumsInitial extends AlbumsState {
  const AlbumsInitial();
}

class AlbumsLoading extends AlbumsState {
  const AlbumsLoading();
}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  const AlbumsLoaded({required this.albums});

  @override
  List<Object?> get props => [albums];
}

class AlbumsError extends AlbumsState {
  final String message;

  const AlbumsError({required this.message});

  @override
  List<Object?> get props => [message];
}
