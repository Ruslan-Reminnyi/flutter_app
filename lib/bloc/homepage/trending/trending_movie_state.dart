part of 'trending_movie_bloc.dart';

class LoadingState {}

class TrendingMovieState {
  final List<int> numbers;
  final ListResponse response;
  final List<MovieModel>? listMovieModel;
  final ListGenresResponse allGenres;
  final List<String?> genres;
  final bool loading;

  TrendingMovieState(
      {required this.numbers,
      required this.response,
        required this.listMovieModel,
        required this.allGenres,
      required this.genres,
      required this.loading});

  TrendingMovieState copyWith({numbers, response, listMovieModel, allGenres, genres, tagline, loading}) {
    return TrendingMovieState(
        numbers: numbers ?? this.numbers,
        response: response ?? this.response,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        allGenres: allGenres ?? this.allGenres,
        genres: genres ?? this.genres,
        loading: loading ?? this.loading);
  }
}
