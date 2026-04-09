import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tk_interview_task/domain/entities/album.dart';
import 'package:tk_interview_task/domain/repositories/album_repository.dart';
import 'package:tk_interview_task/domain/usecases/get_top_albums.dart';
import 'package:tk_interview_task/presentation/bloc/albums_bloc.dart';

class MockAlbumRepository extends Mock implements AlbumRepository {}

const tAlbum = Album(
  id: '1',
  name: 'Test Album',
  artistName: 'Test Artist',
  artworkUrl: 'https://example.com/art.jpg',
  genre: 'Rock',
  releaseDate: 'April 1, 2026',
  price: '\$9.99',
  trackCount: '10',
  albumUrl: 'https://example.com/album',
  rights: '2026 Test Label',
);

void main() {
  late MockAlbumRepository mockRepository;
  late GetTopAlbums usecase;
  late AlbumsBloc bloc;

  setUp(() {
    mockRepository = MockAlbumRepository();
    usecase = GetTopAlbums(mockRepository);
    bloc = AlbumsBloc(getTopAlbums: usecase);
  });

  tearDown(() => bloc.close());

  test('initial state is AlbumsInitial', () {
    expect(bloc.state, const AlbumsInitial());
  });

  group('FetchAlbums', () {
    test('emits [AlbumsLoading, AlbumsLoaded] when fetch succeeds', () async {
      when(() => mockRepository.getTopAlbums())
          .thenAnswer((_) async => [tAlbum]);

      final states = <AlbumsState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const FetchAlbums());
      await Future.delayed(const Duration(milliseconds: 100));
      await subscription.cancel();

      expect(states[0], isA<AlbumsLoading>());
      expect(states[1], isA<AlbumsLoaded>());
      expect((states[1] as AlbumsLoaded).albums, [tAlbum]);
    });

    test('emits [AlbumsLoading, AlbumsError] when fetch fails', () async {
      when(() => mockRepository.getTopAlbums())
          .thenThrow(Exception('Network error'));

      final states = <AlbumsState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const FetchAlbums());
      await Future.delayed(const Duration(milliseconds: 100));
      await subscription.cancel();

      expect(states[0], isA<AlbumsLoading>());
      expect(states[1], isA<AlbumsError>());
      expect((states[1] as AlbumsError).message, contains('Network error'));
    });
  });

  group('GetTopAlbums usecase', () {
    test('calls repository and returns albums', () async {
      when(() => mockRepository.getTopAlbums())
          .thenAnswer((_) async => [tAlbum]);

      final result = await usecase();

      expect(result, [tAlbum]);
      verify(() => mockRepository.getTopAlbums()).called(1);
    });
  });
}
