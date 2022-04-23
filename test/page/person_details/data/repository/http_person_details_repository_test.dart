import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/person_details/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../data.dart';
import '../../../../mock.dart';

void main() {
  late HttpPersonDetailsRepository repository;
  late DioMock dioMock;

  setUp(
    () {
      dioMock = DioMock();
      repository = HttpPersonDetailsRepository(dioMock);
    },
  );

  group(
    'fetchShows',
    () {
      test(
        'should return correct list when success',
        () async {
          when(() => dioMock.get(any(),
              queryParameters: any(named: 'queryParameters'))).thenAnswer(
            (_) async => Response(
              statusCode: httpOk,
              data: [
                {
                  '_embedded': {
                    'show': {
                      ...showFake.toJson(),
                    },
                  },
                },
              ],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          final shows = await repository.fetchShows(1);
          expect(shows, isNotEmpty);
        },
      );

      test(
        'should throw FetchPersonShowsException when status is not ok',
        () async {
          when(() => dioMock.get(any(),
              queryParameters: any(named: 'queryParameters'))).thenAnswer(
            (_) async => Response(
              statusCode: 400,
              data: [],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await repository.fetchShows(1);
          } on Exception catch (e) {
            expect(e, isA<FetchPersonShowsException>());
          }
        },
      );

      test(
        'should throw UnknownException when throw',
        () async {
          when(() => dioMock.get(any(),
              queryParameters: any(named: 'queryParameters'))).thenThrow(
            Exception(),
          );

          try {
            await repository.fetchShows(1);
          } on Exception catch (e) {
            expect(e, isA<UnknownException>());
          }
        },
      );
    },
  );
}
