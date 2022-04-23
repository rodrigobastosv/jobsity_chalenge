import '../data.dart';

abstract class PeopleSearchRepository {
  Future<List<PersonModel>> fetchPeople();
  Future<List<PersonModel>> fetchPeopleByQuery(String query);
}
