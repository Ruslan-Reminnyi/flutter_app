part of 'trending_movie_bloc.dart';

class TrendingMovieState {
  final int? page;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  TrendingMovieState(
      {required this.page,
      required this.listMovieModel,
      required this.loading});

  TrendingMovieState copyWith({page, listMovieModel, loading}) {
    return TrendingMovieState(
        page: page ?? this.page,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        loading: loading ?? this.loading);
  }
}
