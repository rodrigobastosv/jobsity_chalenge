import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/favorite_shows/presenter/cubit/favorite_shows_state.dart';
import 'package:jobsity_chalenge/page/favorite_shows/presenter/presenter.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../../data.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late FavoriteShowsCubitMock cubitMock;

  setUp(
    () {
      cubitMock = FavoriteShowsCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => cubitMock.state).thenReturn(FavoriteShowsState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<FavoriteShowsCubit>.value(
          value: cubitMock,
          child: const FavoriteShowsPage(),
        ),
      );

      expect(find.byType(FavoriteShowsPage), findsOneWidget);
    },
  );

  testWidgets(
    'should show loading indicator if state status is loading',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        FavoriteShowsState.initial().copyWith(
          status: FavoriteShowsStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<FavoriteShowsCubit>.value(
          value: cubitMock,
          child: const FavoriteShowsPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should navigate to showDetailsPage when press on favorite',
    (tester) async {
      final mockNavigator = MockNavigator();
      when(
        () => mockNavigator.pushNamed(
          any(),
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((_) async => {});

      when(() => cubitMock.state).thenReturn(
        FavoriteShowsState.initial().copyWith(
          status: FavoriteShowsStatus.success,
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
        widget: BlocProvider<FavoriteShowsCubit>.value(
          value: cubitMock,
          child: const FavoriteShowsPage(),
        ),
      );

      final images = find.byType(FancyShimmerImage);

      final firstImage = images.first;
      await tester.tap(firstImage);
      await tester.pump();

      expect(images, findsNWidgets(3));
      verify(
        () => mockNavigator.pushNamed(
          showDetailsPage,
          arguments: showFake,
        ),
      ).called(1);
    },
  );
}
