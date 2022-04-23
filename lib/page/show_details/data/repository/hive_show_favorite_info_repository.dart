import 'package:hive/hive.dart';

import '../../../../core/data/model/show_model.dart';
import 'repository.dart';

class HiveShowFavoriteInfoRepository implements ShowFavoriteInfoRepository {
  HiveShowFavoriteInfoRepository({
    required this.userPinBox,
    required this.favoriteMoviesBox,
  });

  final Box userPinBox;
  final Box favoriteMoviesBox;

  @override
  bool isShowFavorited(int showId) {
    final userPin = userPinBox.get('USER_PIN');
    final shows = favoriteMoviesBox.get(userPin) as Map?;

    if (shows == null) {
      return false;
    }

    return shows.containsKey(showId);
  }

  @override
  void favoriteShow(ShowModel show) {
    final userPin = userPinBox.get('USER_PIN');
    final shows = favoriteMoviesBox.get(userPin) as Map? ?? {};
    shows.putIfAbsent(show.id, () => show.toJson());
    favoriteMoviesBox.put(userPin, shows);
  }

  @override
  void unfavoriteShow(ShowModel show) {
    final userPin = userPinBox.get('USER_PIN');
    final shows = favoriteMoviesBox.get(userPin) as Map;
    shows.remove(show.id);
    favoriteMoviesBox.put(userPin, shows);
  }
}
