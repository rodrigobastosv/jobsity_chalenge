import 'package:jobsity_chalenge/core/data/model/show_model.dart';

abstract class HomeRepository {
  Future<List<ShowModel>> fetchShows(int page);
  Future<List<ShowModel>> fetchShowsByQuery(String query);
}
