import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/favorite_shows/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';

void main() {
  late HiveFavoriteShowsRepository repository;
  late BoxMock userPinBoxMock;
  late BoxMock favoriteMoviesBoxMock;

  setUp(
    () {
      userPinBoxMock = BoxMock();
      favoriteMoviesBoxMock = BoxMock();
      repository = HiveFavoriteShowsRepository(
        userPinBox: userPinBoxMock,
        favoriteMoviesBox: favoriteMoviesBoxMock,
      );
    },
  );

  group(
    'fetchFavoriteShows',
    () {
      test(
        'should return empty array if shows is null',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenReturn(null);

          final favoriteShows = await repository.fetchFavoriteShows();
          expect(favoriteShows, isEmpty);
        },
      );

      test(
        'should return array of shows',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenReturn({});

          final favoriteShows = await repository.fetchFavoriteShows();
          expect(favoriteShows, isEmpty);
        },
      );

      test(
        'should throw FavoriteShowsException when Exception',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenThrow(Exception());

          try {
            await repository.fetchFavoriteShows();
          } on Exception catch (e) {
            expect(e, isA<FavoriteShowsException>());
          }
        },
      );

      test(
        'should throw UnknownException when some other thing is thrown',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenThrow('Error');

          try {
            await repository.fetchFavoriteShows();
          } on Exception catch (e) {
            expect(e, isA<UnknownException>());
          }
        },
      );
    },
  );

  group(
    'removeFavoriteShow',
    () {
      test(
        'should remove the show',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenReturn({});
          when(() => favoriteMoviesBoxMock.put(1, any())).thenAnswer((_) async {});

          await repository.removeFavoriteShow(1);
        },
      );

      test(
        'should throw FavoriteShowsException when Exception',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenThrow(Exception());

          try {
            await repository.removeFavoriteShow(1);
          } on Exception catch (e) {
            expect(e, isA<FavoriteShowsException>());
          }
        },
      );

      test(
        'should throw UnknownException when some other thing is thrown',
        () async {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(any())).thenThrow('Error');

          try {
            await repository.removeFavoriteShow(1);
          } on Exception catch (e) {
            expect(e, isA<UnknownException>());
          }
        },
      );
    },
  );
}
