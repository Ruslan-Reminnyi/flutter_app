part of 'trending_movie_bloc.dart';

class LoadingState {}

class TrendingMovieState {
  final List<int> numbers;
  final ListResponse response;
  final List<String?> genres;
  final List<String?> tagline;
  final bool loading;

  TrendingMovieState(
      {required this.numbers,
      required this.response,
      required this.genres,
      required this.tagline,
      required this.loading});

  TrendingMovieState copyWith({numbers, response, genres, tagline, loading}) {
    return TrendingMovieState(
        numbers: numbers ?? this.numbers,
        response: response ?? this.response,
        genres: genres ?? this.genres,
        tagline: tagline ?? this.tagline,
        loading: this.loading);
  }
}
