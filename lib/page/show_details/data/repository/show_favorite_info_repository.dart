import 'package:jobsity_chalenge/core/data/model/show_model.dart';

abstract class ShowFavoriteInfoRepository {
  bool isShowFavorited(int showId);
  void favoriteShow(ShowModel show);
  void unfavoriteShow(ShowModel show);
}
