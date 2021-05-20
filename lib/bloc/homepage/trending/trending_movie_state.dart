part of 'trending_movie_bloc.dart';

abstract class TrendingMovieState {
  final List<int> numbers;
  final ListResponse response;
  final List<String?> genres;
  final List<String?> tagline;

  //REVIEW prefer use of named parameters and copyWith to create new state
  TrendingMovieState({
    required this.numbers,
    required this.response,
    required this.genres,
    required this.tagline,
  });

  @override
  List get props => [];
//REVIEW this will cause issues with your state management. Since you don't override it for any decendants.
//REVIEW Could you explain what is the purpose of using it in
}

class MovieInitState extends TrendingMovieState {
  MovieInitState()
      : super(
          numbers: [],
          response:
              ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []),
          genres: [],
          tagline: [],
        );
}

class LoadingState extends TrendingMovieState {
  LoadingState()
      : super(
          numbers: [],
          response:
              ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []),
          genres: [],
          tagline: [],
        );
}

class LoadedTrendingMoviesState extends TrendingMovieState {
  LoadedTrendingMoviesState(
    List<int> numbers,
    ListResponse response,
    List<String?> genres,
    List<String?> tagline,
  ) : super(
          numbers: numbers,
          response: response,
          genres: genres,
          tagline: tagline,
        );
}
