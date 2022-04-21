import 'package:hive/hive.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';

import '../data.dart';

class HiveFavoriteShowsRepository implements FavoriteShowsRepository {
  HiveFavoriteShowsRepository({
    required this.userPinBox,
    required this.favoriteMoviesBox,
  });

  final Box userPinBox;
  final Box favoriteMoviesBox;

  @override
  Future<List<ShowModel>> fetchFavoriteShows() async {
    try {
      final userPin = userPinBox.get('USER_PIN');
      final shows = favoriteMoviesBox.get(userPin) as Map<dynamic, dynamic>?;

      if (shows == null) {
        return [];
      }

      final listShows = shows.values.toList();
      final list = List.generate(listShows.length,
          (i) => ShowModel.fromJson(Map<String, dynamic>.from(listShows[i])));
      list.sort((s1, s2) => s1.name!.compareTo(s2.name!));
      return list;
    } on Exception {
      throw FavoriteShowsException('Error fetching favorite shows');
    } catch (e) {
      if (e is FavoriteShowsException) {
        rethrow;
      }

      throw UnknownException();
    }
  }

  @override
  Future<void> removeFavoriteShow(int showId) async {
    try {
      final userPin = userPinBox.get('USER_PIN');
      final shows = favoriteMoviesBox.get(userPin) as Map;
      shows.remove(showId);
      favoriteMoviesBox.put(userPin, shows);
    } on Exception {
      throw FavoriteShowsException('Error removing show from favorites');
    } catch (e) {
      if (e is FavoriteShowsException) {
        rethrow;
      }

      throw UnknownException();
    }
  }
}
