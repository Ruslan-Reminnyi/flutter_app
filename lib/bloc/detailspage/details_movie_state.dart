part of 'details_movie_bloc.dart';

class DetailsMovieState {
  final MovieDetailsResponse movieDetailsResponse;
  final int? currentPageOfSimilarMovies;
  final List<MovieModel>? listSimilarMovies;
  final bool loading;

  DetailsMovieState({
    required this.movieDetailsResponse,
    required this.currentPageOfSimilarMovies,
    required this.listSimilarMovies,
    required this.loading,
  });

  DetailsMovieState copyWith({
    MovieDetailsResponse? movieDetailsResponse,
    int? currentPageOfSimilarMovies,
    List<MovieModel>? listSimilarMovies,
    bool? loading,
  }) {
    return DetailsMovieState(
      movieDetailsResponse: movieDetailsResponse ?? this.movieDetailsResponse,
      currentPageOfSimilarMovies:
          currentPageOfSimilarMovies ?? this.currentPageOfSimilarMovies,
      listSimilarMovies: listSimilarMovies ?? this.listSimilarMovies,
      loading: loading ?? this.loading,
    );
  }
}
