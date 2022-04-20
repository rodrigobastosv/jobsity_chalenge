import 'package:dio/dio.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/home/data/repository/home_repository.dart';

import '../../../../core/data/model/model.dart';
import '../exception/exception.dart';

class HttpHomeRepository implements HomeRepository {
  HttpHomeRepository(this.client);

  final Dio client;

  @override
  Future<List<ShowModel>> fetchShows(int page) async {
    try {
      final clientResponse = await client.get(
        '/shows',
        queryParameters: {
          'page': page,
        },
      );

      if (clientResponse.statusCode == httpOk) {
        final listShowResponse = clientResponse.data as List;
        return List.generate(
          listShowResponse.length,
          (i) => ShowModel.fromJson(listShowResponse[i]),
        );
      } else {
        throw FetchShowException('Error Fetching shows');
      }
    } on Exception catch (e) {
      if (e is FetchShowException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }

  @override
  Future<List<ShowModel>> fetchShowsByQuery(String query) async {
    try {
      final clientResponse = await client.get(
        '/search/shows',
        queryParameters: {
          'q': query,
        },
      );

      if (clientResponse.statusCode == httpOk) {
        final listShowResponse = clientResponse.data as List;
        return List.generate(
          listShowResponse.length,
          (i) => ShowModel.fromJson(listShowResponse[i]['show']),
        );
      } else {
        throw FetchShowException('Error Fetching shows with $query');
      }
    } on Exception catch (e) {
      if (e is FetchShowException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }
}
