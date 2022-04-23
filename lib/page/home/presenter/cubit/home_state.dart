import 'package:equatable/equatable.dart';

import '../../../../core/data/model/model.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ShowModel> shows;
  final String query;
  final String errorMessage;
  final int page;

  const HomeState({
    required this.status,
    required this.shows,
    required this.query,
    required this.errorMessage,
    required this.page,
  });

  factory HomeState.initial() => const HomeState(
        status: HomeStatus.initial,
        shows: [],
        query: '',
        errorMessage: '',
        page: 0,
      );

  HomeState copyWith({
    HomeStatus? status,
    List<ShowModel>? shows,
    String? query,
    String? errorMessage,
    int? page,
  }) {
    return HomeState(
      status: status ?? this.status,
      shows: shows ?? this.shows,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        status,
        shows,
        query,
        errorMessage,
        page,
      ];
}
