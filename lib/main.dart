import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tk_interview_task/core/theme.dart';
import 'package:tk_interview_task/data/datasources/itunes_remote_datasource.dart';
import 'package:tk_interview_task/data/repositories/album_repository_impl.dart';
import 'package:tk_interview_task/domain/usecases/get_top_albums.dart';
import 'package:tk_interview_task/presentation/bloc/albums_bloc.dart';
import 'package:tk_interview_task/presentation/pages/albums_list_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final datasource = ItunesRemoteDatasourceImpl(client: client);
    final repository = AlbumRepositoryImpl(remoteDatasource: datasource);
    final usecase = GetTopAlbums(repository);

    return BlocProvider(
      create: (_) => AlbumsBloc(getTopAlbums: usecase),
      child: MaterialApp(
        title: 'Top Albums',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const AlbumsListPage(),
      ),
    );
  }
}
