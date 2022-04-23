import 'package:dio/dio.dart';

import '../../../../core/core.dart';
import '../data.dart';

class HttpPeopleSearchRepository implements PeopleSearchRepository {
  HttpPeopleSearchRepository(this._client);

  final Dio _client;

  @override
  Future<List<PersonModel>> fetchPeople() async {
    try {
      final clientResponse = await _client.get(
        '/people',
      );

      if (clientResponse.statusCode == httpOk) {
        final listResponse = clientResponse.data as List;
        return List.generate(
          listResponse.length,
          (i) => PersonModel.fromJson(listResponse[i]),
        );
      } else {
        throw FetchPeopleSearchException('Error Fetching people');
      }
    } on Exception catch (e) {
      if (e is FetchPeopleSearchException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }

  @override
  Future<List<PersonModel>> fetchPeopleByQuery(String query) async {
    try {
      final clientResponse = await _client.get(
        '/search/people',
        queryParameters: {
          'q': query,
        },
      );

      if (clientResponse.statusCode == httpOk) {
        final listResponse = clientResponse.data as List;
        return List.generate(
          listResponse.length,
          (i) => PersonModel.fromJson(listResponse[i]['person']),
        );
      } else {
        throw FetchPeopleSearchException('Error Fetching people by query');
      }
    } on Exception catch (e) {
      if (e is FetchPeopleSearchException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }
}
