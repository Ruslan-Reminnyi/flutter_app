part of 'upcoming_movie_bloc.dart';

class LoadingState {}

class UpcomingMovieState {
  final ListResponse response;
  final List<MovieModel>? listMovieModel;
  final List<String?> currentGenres;
  final bool loading;

  UpcomingMovieState(
      {required this.response,
      required this.listMovieModel,
      required this.currentGenres,
      required this.loading});

  UpcomingMovieState copyWith(
      {response, listMovieModel, currentGenres, loading}) {
    return UpcomingMovieState(
        response: response ?? this.response,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        currentGenres: currentGenres ?? this.currentGenres,
        loading: loading ?? this.loading);
  }
}
