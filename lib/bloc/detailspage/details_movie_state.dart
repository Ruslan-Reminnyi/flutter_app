part of 'details_movie_bloc.dart';

class LoadingState {}

class DetailsMovieState {
  final MovieDetailsResponse movieDetailsResponse;
  final int? currentPageOfSimilarMovies;
  final List<MovieModel>? listSimilarMovies;
  final bool loading;

  DetailsMovieState(
      {required this.movieDetailsResponse,
      required this.currentPageOfSimilarMovies,
      required this.listSimilarMovies,
      required this.loading});

  DetailsMovieState copyWith(
      {movieDetailsResponse,
      currentPageOfSimilarMovies,
      listSimilarMovies,
      loading}) {
    return DetailsMovieState(
        movieDetailsResponse: movieDetailsResponse ?? this.movieDetailsResponse,
        currentPageOfSimilarMovies:
            currentPageOfSimilarMovies ?? this.currentPageOfSimilarMovies,
        listSimilarMovies: listSimilarMovies ?? this.listSimilarMovies,
        loading: loading ?? this.loading);
  }
}
