import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:jobsity_chalenge/core/data/model/model.dart';
import 'package:jobsity_chalenge/page/favorite_shows/favorite_shows.dart';
import 'package:jobsity_chalenge/page/favorite_shows/presenter/cubit/favorite_shows_state.dart';
import 'package:jobsity_chalenge/page/home/data/repository/home_repository.dart';
import 'package:jobsity_chalenge/page/home/home.dart';
import 'package:jobsity_chalenge/page/home/presenter/cubit/home_state.dart';
import 'package:jobsity_chalenge/page/people_search/data/repository/people_search_repository.dart';
import 'package:jobsity_chalenge/page/people_search/presenter/cubit/people_search_state.dart';
import 'package:jobsity_chalenge/page/people_search/presenter/presenter.dart';
import 'package:jobsity_chalenge/page/person_details/person_details.dart';
import 'package:jobsity_chalenge/page/person_details/presenter/cubit/person_details_state.dart';
import 'package:jobsity_chalenge/page/show_details/presenter/cubit/show_details_state.dart';
import 'package:jobsity_chalenge/page/show_details/show_details.dart';
import 'package:mockingjay/mockingjay.dart';

// Cubit
class HomeCubitMock extends MockCubit<HomeState> implements HomeCubit {}

class FavoriteShowsCubitMock extends MockCubit<FavoriteShowsState>
    implements FavoriteShowsCubit {}

class PeopleSearchCubitMock extends MockCubit<PeopleSearchState>
    implements PeopleSearchCubit {}

class PersonDetailsCubitMock extends MockCubit<PersonDetailsState>
    implements PersonDetailsCubit {}

class ShowDetailsCubitMock extends MockCubit<ShowDetailsState>
    implements ShowDetailsCubit {}

// Repository
class HomeRepositoryMock extends Mock implements HomeRepository {}

class FavoriteShowsRepositoryMock extends Mock
    implements FavoriteShowsRepository {}

class PeopleSearchRepositoryMock extends Mock
    implements PeopleSearchRepository {}

class PersonDetailsRepositoryMock extends Mock
    implements PersonDetailsRepository {}

class ShowDetailsRepositoryMock extends Mock implements ShowDetailsRepository {}

class ShowFavoriteInfoRepositoryMock extends Mock
    implements ShowFavoriteInfoRepository {}

// General
class BoxMock extends Mock implements Box {}

class DioMock extends Mock implements Dio {}

// Fake
class ShowModelFake extends Fake implements ShowModel {}