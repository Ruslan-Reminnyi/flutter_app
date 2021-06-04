part of 'details_movie_bloc.dart';

class LoadingState {}

class DetailsMovieState {
  final MovieDetailsResponse movieDetailsResponse;
  final List<String?> genresOfSimilarMovie;
  final int? currentPageOfSimilarMovies;
  final List<MovieModel>? listSimilarMovies;
  final bool loading;

  DetailsMovieState(
      {required this.movieDetailsResponse,
      required this.genresOfSimilarMovie,
      required this.currentPageOfSimilarMovies,
      required this.listSimilarMovies,
      required this.loading});

  DetailsMovieState copyWith(
      {movieDetailsResponse,
      genresOfSimilarMovie,
      currentPageOfSimilarMovies,
      listSimilarMovies,
      loading}) {
    return DetailsMovieState(
        movieDetailsResponse: movieDetailsResponse ?? this.movieDetailsResponse,
        genresOfSimilarMovie: genresOfSimilarMovie ?? this.genresOfSimilarMovie,
        currentPageOfSimilarMovies:
            currentPageOfSimilarMovies ?? this.currentPageOfSimilarMovies,
        listSimilarMovies: listSimilarMovies ?? this.listSimilarMovies,
        loading: loading ?? this.loading);
  }
}
