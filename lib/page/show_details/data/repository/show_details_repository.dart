import '../../../../core/data/model/show_episode_model.dart';

abstract class ShowDetailsRepository {
  Future<List<ShowEpisodeModel>> fetchEpisodes(int showId);
}
