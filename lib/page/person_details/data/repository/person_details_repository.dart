import 'package:jobsity_chalenge/core/data/model/show_model.dart';

abstract class PersonDetailsRepository {
  Future<List<ShowModel>> fetchShows(int personId);
}
