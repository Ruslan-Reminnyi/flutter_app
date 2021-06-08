part of 'upcoming_movie_bloc.dart';

class LoadingState {}

class UpcomingMovieState {
  final ListResponse response;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  UpcomingMovieState(
      {required this.response,
      required this.listMovieModel,
      required this.loading});

  UpcomingMovieState copyWith({response, listMovieModel, loading}) {
    return UpcomingMovieState(
        response: response ?? this.response,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        loading: loading ?? this.loading);
  }
}
