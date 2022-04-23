import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/show_details/show_details.dart';
import '../../../../data.dart';
import '../../../../mock.dart';

void main() {
  late HttpShowDetailsRepository repository;
  late DioMock dioMock;

  setUp(
    () {
      dioMock = DioMock();
      repository = HttpShowDetailsRepository(dioMock);
    },
  );

  group(
    'fetchEpisodes',
    () {
      test(
        'should return correct list when success',
        () async {
          when(() => dioMock.get(any())).thenAnswer(
            (_) async => Response(
              statusCode: httpOk,
              data: [
                episodeFake.toJson(),
              ],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          final shows = await repository.fetchEpisodes(1);
          expect(shows, isNotEmpty);
        },
      );

      test(
        'should throw FetchShowEpisodesException when status is not ok',
        () async {
          when(() => dioMock.get(any())).thenAnswer(
            (_) async => Response(
              statusCode: 400,
              data: [],
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await repository.fetchEpisodes(1);
          } on Exception catch (e) {
            expect(e, isA<FetchShowEpisodesException>());
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
            await repository.fetchEpisodes(1);
          } on Exception catch (e) {
            expect(e, isA<UnknownException>());
          }
        },
      );
    },
  );
}
