import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tk_interview_task/core/constants.dart';
import 'package:tk_interview_task/data/models/album_model.dart';

abstract class ItunesRemoteDatasource {
  Future<List<AlbumModel>> getTopAlbums();
}

class ItunesRemoteDatasourceImpl implements ItunesRemoteDatasource {
  final http.Client client;

  const ItunesRemoteDatasourceImpl({required this.client});

  @override
  Future<List<AlbumModel>> getTopAlbums() async {
    final response = await client.get(Uri.parse(ApiConstants.topAlbumsUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final entries = body['feed']['entry'] as List<dynamic>;

    return entries
        .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
