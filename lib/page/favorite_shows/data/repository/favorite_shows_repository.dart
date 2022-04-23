import '../../../../core/data/model/show_model.dart';

abstract class FavoriteShowsRepository {
  Future<List<ShowModel>> fetchFavoriteShows();
  Future<void> removeFavoriteShow(int showId);
}
