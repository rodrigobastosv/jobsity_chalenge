import 'package:equatable/equatable.dart';

import '../../../../core/data/model/model.dart';
import '../../../../core/data/model/show_episode_model.dart';

enum ShowDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class ShowDetailsState extends Equatable {
  final ShowModel show;
  final bool? isShowFavorited;
  final List<ShowEpisodeModel> episodes;
  final ShowDetailsStatus status;
  final String query;
  final String errorMessage;

  const ShowDetailsState({
    required this.show,
    required this.isShowFavorited,
    required this.episodes,
    required this.status,
    required this.query,
    required this.errorMessage,
  });

  factory ShowDetailsState.initial(ShowModel show) => ShowDetailsState(
        show: show,
        isShowFavorited: null,
        episodes: const [],
        status: ShowDetailsStatus.initial,
        query: '',
        errorMessage: '',
      );

  ShowDetailsState copyWith({
    ShowModel? show,
    bool? isShowFavorited,
    List<ShowEpisodeModel>? episodes,
    ShowDetailsStatus? status,
    String? query,
    String? errorMessage,
  }) {
    return ShowDetailsState(
      show: show ?? this.show,
      isShowFavorited: isShowFavorited ?? this.isShowFavorited,
      episodes: episodes ?? this.episodes,
      status: status ?? this.status,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        show,
        isShowFavorited,
        episodes,
        status,
        query,
        errorMessage,
      ];
}
