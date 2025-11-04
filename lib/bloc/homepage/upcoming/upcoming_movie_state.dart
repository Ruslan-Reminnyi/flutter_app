part of 'upcoming_movie_bloc.dart';

class UpcomingMovieState {
  final int? page;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  UpcomingMovieState(
      {required this.page,
      required this.listMovieModel,
      required this.loading});

  UpcomingMovieState copyWith({page, listMovieModel, loading}) {
    return UpcomingMovieState(
        page: page ?? this.page,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        loading: loading ?? this.loading);
  }
}
