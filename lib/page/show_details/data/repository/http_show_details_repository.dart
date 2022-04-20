import 'package:dio/dio.dart';
import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';

import '../../../../core/core.dart';
import '../data.dart';

class HttpShowDetailsRepository implements ShowDetailsRepository {
  HttpShowDetailsRepository(this.client);

  final Dio client;

  @override
  Future<List<ShowEpisodeModel>> fetchEpisodes(int showId) async {
    try {
      final clientResponse = await client.get(
        '/shows/$showId/episodes',
      );

      if (clientResponse.statusCode == httpOk) {
        final listShowResponse = clientResponse.data as List;
        return List.generate(
          listShowResponse.length,
          (i) => ShowEpisodeModel.fromJson(listShowResponse[i]),
        );
      } else {
        throw FetchShowEpisodesException('Error Fetching episodes of the show');
      }
    } on Exception catch (e) {
      if (e is FetchShowEpisodesException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }
}