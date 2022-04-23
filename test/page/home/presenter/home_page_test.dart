import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/page/home/home.dart';
import 'package:jobsity_chalenge/page/home/presenter/cubit/home_state.dart';
import 'package:jobsity_chalenge/page/home/presenter/widget/widget.dart';
import 'package:jobsity_chalenge/ui/ui.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../../data.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late HomeCubitMock cubitMock;

  setUp(
    () {
      cubitMock = HomeCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => cubitMock.state).thenReturn(HomeState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<HomeCubit>.value(
          value: cubitMock,
          child: const HomePage(),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
    },
  );

  testWidgets(
    'typing on search field should call cubit onChangeQuery',
    (tester) async {
      when(() => cubitMock.state).thenReturn(HomeState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<HomeCubit>.value(
          value: cubitMock,
          child: const HomePage(),
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
      when(() => cubitMock.state).thenReturn(HomeState.initial());
      when(() => cubitMock.fetchShowsByQuery()).thenAnswer((_) async => {});

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<HomeCubit>.value(
          value: cubitMock,
          child: const HomePage(),
        ),
      );

      final searchIcon = find.byIcon(Icons.search);
      await tester.tap(searchIcon);
      verify(() => cubitMock.fetchShowsByQuery()).called(1);
    },
  );

  testWidgets(
    'should show loading indicator is status is loading',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        HomeState.initial().copyWith(
          status: HomeStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<HomeCubit>.value(
          value: cubitMock,
          child: const HomePage(),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show listview if shows is not empty',
    (tester) async {
      when(() => cubitMock.state).thenReturn(
        HomeState.initial().copyWith(
          status: HomeStatus.success,
          shows: [
            showFake,
            showFake,
            showFake,
          ],
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<HomeCubit>.value(
          value: cubitMock,
          child: const HomePage(),
        ),
      );

      expect(find.byType(ShowsListView), findsOneWidget);
    },
  );
}
