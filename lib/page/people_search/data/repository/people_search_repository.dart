import '../data.dart';

abstract class PeopleSearchRepository {
  Future<List<PersonModel>> fetchPeopleByPage(int page);
  Future<List<PersonModel>> fetchPeopleByQuery(String query);
}
