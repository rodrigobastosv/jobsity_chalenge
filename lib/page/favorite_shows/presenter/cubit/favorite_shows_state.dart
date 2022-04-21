import 'package:equatable/equatable.dart';

import '../../../../core/data/model/model.dart';

enum FavoriteShowsStatus {
  initial,
  loading,
  success,
  failure,
}

class FavoriteShowsState extends Equatable {
  final List<ShowModel> shows;
  final FavoriteShowsStatus status;
  final String errorMessage;

  const FavoriteShowsState({
    required this.shows,
    required this.status,
    required this.errorMessage,
  });

  factory FavoriteShowsState.initial() => const FavoriteShowsState(
        shows: [],
        status: FavoriteShowsStatus.initial,
        errorMessage: '',
      );

  FavoriteShowsState copyWith({
    List<ShowModel>? shows,
    FavoriteShowsStatus? status,
    String? errorMessage,
  }) {
    return FavoriteShowsState(
      shows: shows ?? this.shows,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        shows,
        status,
        errorMessage,
      ];
}
