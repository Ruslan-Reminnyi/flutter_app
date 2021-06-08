part of 'trending_movie_bloc.dart';

class LoadingState {}

class TrendingMovieState {
  final ListResponse response;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  TrendingMovieState(
      {required this.response,
      required this.listMovieModel,
      required this.loading});

  TrendingMovieState copyWith({response, listMovieModel, loading}) {
    return TrendingMovieState(
        response: response ?? this.response,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        loading: loading ?? this.loading);
  }
}
