import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tk_interview_task/domain/entities/album.dart';
import 'package:tk_interview_task/domain/usecases/get_top_albums.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final GetTopAlbums getTopAlbums;

  AlbumsBloc({required this.getTopAlbums}) : super(const AlbumsInitial()) {
    on<FetchAlbums>(_onFetchAlbums);
  }

  Future<void> _onFetchAlbums(
    FetchAlbums event,
    Emitter<AlbumsState> emit,
  ) async {
    emit(const AlbumsLoading());
    try {
      final albums = await getTopAlbums();
      emit(AlbumsLoaded(albums: albums));
    } catch (e) {
      emit(AlbumsError(message: e.toString()));
    }
  }
}
