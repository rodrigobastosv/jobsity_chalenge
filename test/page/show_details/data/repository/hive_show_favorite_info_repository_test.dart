import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/page/show_details/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../data.dart';
import '../../../../mock.dart';

void main() {
  late HiveShowFavoriteInfoRepository repository;
  late BoxMock userPinBoxMock;
  late BoxMock favoriteMoviesBoxMock;

  setUp(
    () {
      userPinBoxMock = BoxMock();
      favoriteMoviesBoxMock = BoxMock();
      repository = HiveShowFavoriteInfoRepository(
        userPinBox: userPinBoxMock,
        favoriteMoviesBox: favoriteMoviesBoxMock,
      );
    },
  );

  group(
    'isShowFavorited',
    () {
      test(
        'should return false if shows is null',
        () {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(1)).thenReturn(null);

          final isShowFavorited = repository.isShowFavorited(1);
          expect(isShowFavorited, false);
        },
      );

      test(
        'should return if value contains',
        () {
          when(() => userPinBoxMock.get(any())).thenReturn(1);
          when(() => favoriteMoviesBoxMock.get(1)).thenReturn(
            {
              1: showFake,
            },
          );

          final isShowFavorited = repository.isShowFavorited(1);
          expect(isShowFavorited, true);
        },
      );
    },
  );

  test(
    'should favorite a show',
    () {
      when(() => userPinBoxMock.get(any())).thenReturn(1);
      when(() => favoriteMoviesBoxMock.get(1)).thenReturn({});
      when(() => favoriteMoviesBoxMock.put(any(), any())).thenAnswer((_) async => {});

      repository.favoriteShow(showFake);
    },
  );

  test(
    'should unfavorite a show',
    () {
      when(() => userPinBoxMock.get(any())).thenReturn(1);
      when(() => favoriteMoviesBoxMock.get(1)).thenReturn({});
      when(() => favoriteMoviesBoxMock.put(any(), any())).thenAnswer((_) async => {});

      repository.unfavoriteShow(showFake);
    },
  );
}
