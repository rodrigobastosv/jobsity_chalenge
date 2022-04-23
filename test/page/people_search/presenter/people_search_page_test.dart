import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/people_search/presenter/cubit/people_search_state.dart';
import 'package:jobsity_chalenge/page/people_search/presenter/presenter.dart';
import '../../../data.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late PeopleSearchCubitMock cubitMock;

  setUp(
    () {
      cubitMock = PeopleSearchCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => cubitMock.state).thenReturn(PeopleSearchState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PeopleSearchCubit>.value(
          value: cubitMock,
          child: const PeopleSearchPage(),
        ),
      );

      expect(find.byType(PeopleSearchPage), findsOneWidget);
    },
  );

  testWidgets(
    'typing on search field should call cubit onChangeQuery',
    (tester) async {
      when(() => cubitMock.state).thenReturn(PeopleSearchState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PeopleSearchCubit>.value(
          value: cubitMock,
          child: const PeopleSearchPage(),
        ),
      );

      final textFormField = find.byType(TextFormField);
      await tester.enterText(textFormField, 'mike');
      verify(() => cubitMock.onChangeQuery('mike')).called(1);
    },
  );

  testWidgets(
    'taping on search icon should call cubit fetchShowsByQuery',
    (tester) async {
      when(() => cubitMock.state).thenReturn(PeopleSearchState.initial());
      when(() => cubitMock.fetchPeopleByQuery()).thenAnswer((_) async => {});

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PeopleSearchCubit>.value(
          value: cubitMock,
          child: const PeopleSearchPage(),
        ),
      );

      final searchIcon = find.byIcon(Icons.search);
      await tester.tap(searchIcon);
      verify(() => cubitMock.fetchPeopleByQuery()).called(1);
    },
  );

  testWidgets(
    'should show loading indicator is status is loading',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        PeopleSearchState.initial().copyWith(
          status: PeopleSearchStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PeopleSearchCubit>.value(
          value: cubitMock,
          child: const PeopleSearchPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show listview if shows is not empty',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        PeopleSearchState.initial().copyWith(
          status: PeopleSearchStatus.success,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PeopleSearchCubit>.value(
          value: cubitMock,
          child: const PeopleSearchPage(),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    },
  );

  testWidgets(
    'should navigate to personDetailsPage when press list tile',
    (tester) async {
      mockNetworkImagesFor(
        () async {
          final mockNavigator = MockNavigator();
          when(
            () => mockNavigator.pushNamed(
              any(),
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) async => {});
          when(() => cubitMock.state).thenReturn(
            PeopleSearchState.initial().copyWith(
              status: PeopleSearchStatus.success,
              people: [
                personFake,
                personFake,
                personFake,
              ],
            ),
          );

          await pumpWidgetWithAppNavigation(
            tester,
            mockNavigator,
            widget: BlocProvider<PeopleSearchCubit>.value(
              value: cubitMock,
              child: const PeopleSearchPage(),
            ),
          );

          final listTile = find.byType(ListTile).first;
          await tester.tap(listTile);

          verify(
            () => mockNavigator.pushNamed(
              personDetailsPage,
              arguments: personFake,
            ),
          ).called(1);
        },
      );
    },
  );
}
