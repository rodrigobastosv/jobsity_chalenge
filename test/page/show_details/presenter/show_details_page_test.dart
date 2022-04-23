import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/show_details/presenter/cubit/show_details_state.dart';
import 'package:jobsity_chalenge/page/show_details/show_details.dart';
import '../../../data.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late ShowDetailsCubitMock cubitMock;

  setUp(
    () {
      cubitMock = ShowDetailsCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        ShowDetailsState.initial(showFake).copyWith(
          isShowFavorited: true,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<ShowDetailsCubit>.value(
          value: cubitMock,
          child: ShowDetailsPage(),
        ),
      );

      expect(find.byType(ShowDetailsPage), findsOneWidget);
    },
  );

  testWidgets(
    'should show loading if status is loading',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        ShowDetailsState.initial(showFake).copyWith(
          isShowFavorited: false,
          status: ShowDetailsStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<ShowDetailsCubit>.value(
          value: cubitMock,
          child: ShowDetailsPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should call toggleFavoriteShow from cubit when press favorite icon',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        ShowDetailsState.initial(showFake).copyWith(
          isShowFavorited: false,
          status: ShowDetailsStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<ShowDetailsCubit>.value(
          value: cubitMock,
          child: ShowDetailsPage(),
        ),
      );

      final favoriteIcon = find.byKey(const ValueKey('favorite_icon_key'));
      await tester.tap(favoriteIcon);
      verify(() => cubitMock.toggleFavoriteShow()).called(1);
    },
  );

  testWidgets(
    'should show list of episodes if success',
    (tester) async {
      mockNetworkImagesFor(
        () async {
          when(() => cubitMock.state).thenReturn(
            ShowDetailsState.initial(showFake).copyWith(
              isShowFavorited: false,
              status: ShowDetailsStatus.success,
              episodes: [
                episodeFake,
                episodeFake,
                episodeFake,
              ],
            ),
          );

          await pumpWidgetWithApp(
            tester,
            widget: BlocProvider<ShowDetailsCubit>.value(
              value: cubitMock,
              child: ShowDetailsPage(),
            ),
          );

          expect(find.byType(ListView), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'should navigate to episodeDetailsPage when click on episode',
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
            ShowDetailsState.initial(showFake).copyWith(
              isShowFavorited: false,
              status: ShowDetailsStatus.success,
              episodes: [
                episodeFake,
                episodeFake,
                episodeFake,
              ],
            ),
          );

          await pumpWidgetWithAppNavigation(
            tester,
            mockNavigator,
            widget: BlocProvider<ShowDetailsCubit>.value(
              value: cubitMock,
              child: ShowDetailsPage(),
            ),
          );

          final episodeTile = find.byType(ListTile).first;
          await tester.tap(episodeTile);
          verify(
            () => mockNavigator.pushNamed(
              episodeDetailsPage,
              arguments: episodeFake,
            ),
          ).called(1);
        },
      );
    },
  );
}
