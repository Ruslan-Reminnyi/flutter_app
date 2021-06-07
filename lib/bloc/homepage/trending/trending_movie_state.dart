part of 'trending_movie_bloc.dart';

class LoadingState {}

class TrendingMovieState {
  final ListResponse response;
  final List<MovieModel>? listMovieModel;
  final ListGenresResponse allApiGenres;
  final List<String?> currentGenres;
  final bool loading;

  TrendingMovieState(
      {required this.response,
      required this.listMovieModel,
      required this.allApiGenres,
      required this.currentGenres,
      required this.loading});

  TrendingMovieState copyWith(
      {response,
      listMovieModel,
      allApiGenres,
      currentGenres,
      tagline,
      loading}) {
    return TrendingMovieState(
        response: response ?? this.response,
        listMovieModel: listMovieModel ?? this.listMovieModel,
        allApiGenres: allApiGenres ?? this.allApiGenres,
        currentGenres: currentGenres ?? this.currentGenres,
        loading: loading ?? this.loading);
  }
}
