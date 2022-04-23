import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/person_details/presenter/cubit/person_details_state.dart';
import 'package:jobsity_chalenge/page/person_details/presenter/presenter.dart';
import '../../../data.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late PersonDetailsCubitMock cubitMock;

  setUp(
    () {
      cubitMock = PersonDetailsCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => cubitMock.state)
          .thenReturn(PersonDetailsState.initial(personFake));

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PersonDetailsCubit>.value(
          value: cubitMock,
          child: const PersonDetailsPage(),
        ),
      );

      expect(find.byType(PersonDetailsPage), findsOneWidget);
    },
  );

  testWidgets(
    'should show animation if success and empty list',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        PersonDetailsState.initial(personFake).copyWith(
          status: PersonDetailsStatus.success,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PersonDetailsCubit>.value(
          value: cubitMock,
          child: const PersonDetailsPage(),
        ),
      );

      expect(find.byType(LottieBuilder), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message if failure',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        PersonDetailsState.initial(personFake).copyWith(
          status: PersonDetailsStatus.failure,
          errorMessage: 'error',
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PersonDetailsCubit>.value(
          value: cubitMock,
          child: const PersonDetailsPage(),
        ),
      );

      expect(find.text('error'), findsOneWidget);
    },
  );

  testWidgets(
    'should show listview if success and not empty list',
    (tester) async {
      mockNetworkImagesFor(
        () async {
          when(() => cubitMock.state).thenReturn(
            PersonDetailsState.initial(personFake).copyWith(
              status: PersonDetailsStatus.success,
              shows: [
                showFake,
                showFake,
                showFake,
              ],
            ),
          );

          await pumpWidgetWithApp(
            tester,
            widget: BlocProvider<PersonDetailsCubit>.value(
              value: cubitMock,
              child: const PersonDetailsPage(),
            ),
          );

          expect(find.byType(ListView), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'should navigate to show page when click show',
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
            PersonDetailsState.initial(personFake).copyWith(
              status: PersonDetailsStatus.success,
              shows: [
                showFake,
                showFake,
                showFake,
              ],
            ),
          );

          await pumpWidgetWithAppNavigation(
            tester,
            mockNavigator,
            widget: BlocProvider<PersonDetailsCubit>.value(
              value: cubitMock,
              child: const PersonDetailsPage(),
            ),
          );

          final show = find.byType(ListTile).first;
          await tester.tap(show);
          verify(
            () => mockNavigator.pushNamed(
              showDetailsPage,
              arguments: showFake,
            ),
          ).called(1);
        },
      );
    },
  );

  testWidgets(
    'should show loading indicator is status is loading',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        PersonDetailsState.initial(personFake).copyWith(
          status: PersonDetailsStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<PersonDetailsCubit>.value(
          value: cubitMock,
          child: const PersonDetailsPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
