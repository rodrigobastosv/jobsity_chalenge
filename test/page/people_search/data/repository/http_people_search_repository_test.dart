import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/people_search/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';

void main() {
  late HttpPeopleSearchRepository repository;
  late DioMock dioMock;

  setUp(
    () {
      dioMock = DioMock();
      repository = HttpPeopleSearchRepository(dioMock);
    },
  );

  group(
    'fetchPeople',
    () {
      test(
        'should return correct list when success',
        () async {
          when(() => dioMock.get(any())).thenAnswer(
            (_) async => Response(
              statusCode: httpOk,
              data: [
                {
                  'id': 1,
                },
              ],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          final people = await repository.fetchPeople();
          expect(people, isNotEmpty);
        },
      );

      test(
        'should throw FetchPeopleSearchException when status is not ok',
        () async {
          when(() => dioMock.get(any())).thenAnswer(
            (_) async => Response(
              statusCode: 400,
              data: [],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await repository.fetchPeople();
          } on Exception catch (e) {
            expect(e, isA<FetchPeopleSearchException>());
          }
        },
      );

      test(
        'should throw FetchPeopleSearchException when exception',
        () async {
          when(() => dioMock.get(any())).thenThrow(
            FetchPeopleSearchException('error'),
          );

          try {
            await repository.fetchPeople();
          } on Exception catch (e) {
            expect(e, isA<FetchPeopleSearchException>());
          }
        },
      );

      test(
        'should throw UnknownException when throw',
        () async {
          when(() => dioMock.get(any())).thenThrow(
            Exception(),
          );

          try {
            await repository.fetchPeople();
          } on Exception catch (e) {
            expect(e, isA<UnknownException>());
          }
        },
      );
    },
  );

  group(
    'fetchPeopleByQuery',
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
                  'person': {
                    'id': 1,
                  },
                },
              ],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          final people = await repository.fetchPeopleByQuery('mike');
          expect(people, isNotEmpty);
        },
      );

      test(
        'should throw FetchPeopleSearchException when status is not ok',
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
            await repository.fetchPeopleByQuery('mike');
          } on Exception catch (e) {
            expect(e, isA<FetchPeopleSearchException>());
          }
        },
      );

      test(
        'should throw FetchPeopleSearchException when exception',
        () async {
          when(() => dioMock.get(any(),
              queryParameters: any(named: 'queryParameters'))).thenThrow(
            FetchPeopleSearchException('error'),
          );

          try {
            await repository.fetchPeopleByQuery('mike');
          } on Exception catch (e) {
            expect(e, isA<FetchPeopleSearchException>());
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
            await repository.fetchPeopleByQuery('mike');
          } on Exception catch (e) {
            expect(e, isA<UnknownException>());
          }
        },
      );
    },
  );
}
