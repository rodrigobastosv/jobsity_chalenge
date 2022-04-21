import 'package:jobsity_chalenge/page/people_search/data/data.dart';

abstract class PeopleSearchRepository {
  Future<List<PersonModel>> fetchPeople();
}