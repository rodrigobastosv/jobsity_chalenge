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

  const HomeState({
    required this.status,
    required this.shows,
    required this.query,
    required this.errorMessage,
  });

  factory HomeState.initial() => const HomeState(
        status: HomeStatus.initial,
        shows: [],
        query: '',
        errorMessage: '',
      );

  HomeState copyWith({
    HomeStatus? status,
    List<ShowModel>? shows,
    String? query,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      shows: shows ?? this.shows,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        shows,
        query,
        errorMessage,
      ];
}
