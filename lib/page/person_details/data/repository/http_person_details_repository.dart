import 'package:dio/dio.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';

import '../../../../core/core.dart';
import '../data.dart';

class HttpPersonDetailsRepository implements PersonDetailsRepository {
  HttpPersonDetailsRepository(this._client);

  final Dio _client;

  @override
  Future<List<ShowModel>> fetchShows(int personId) async {
    try {
      final clientResponse = await _client.get(
        '/people/$personId/crewcredits',
        queryParameters: {
          'embed': 'show',
        },
      );

      if (clientResponse.statusCode == httpOk) {
        final listShowResponse = clientResponse.data as List;
        return List.generate(
          listShowResponse.length,
          (i) => ShowModel.fromJson(listShowResponse[i]['_embedded']['show']),
        );
      } else {
        throw FetchPersonShowsException('Error Fetching shows of the person');
      }
    } on Exception catch (e) {
      if (e is FetchPersonShowsException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }

}