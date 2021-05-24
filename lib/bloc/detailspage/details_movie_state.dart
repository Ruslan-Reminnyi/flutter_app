part of 'details_movie_bloc.dart';

abstract class DetailsMovieState {
  final MovieDetailsResponse movieDetailsResponse;
  final List<String?> genresOfSimilarMovie;

  DetailsMovieState(
      {required this.movieDetailsResponse,
      required this.genresOfSimilarMovie});

  @override
  List get props => [];
}

class DetailsMovieInitState extends DetailsMovieState {
  DetailsMovieInitState()
      : super(
            movieDetailsResponse: MovieDetailsResponse(
              id: 0,
              originalTitle: '',
              tagline: '',
              overview: '',
              posterPath: '',
              genres: [],
              productionCompanies: [],
              runtime: 0,
            ),
            genresOfSimilarMovie: []);
}

class DetailsLoadingState extends DetailsMovieState {
  DetailsLoadingState()
      : super(
            movieDetailsResponse: MovieDetailsResponse(
                id: 0,
                originalTitle: '',
                tagline: '',
                overview: '',
                posterPath: '',
                genres: [],
                productionCompanies: [],
                runtime: 0,
                rating: 0.0),
            genresOfSimilarMovie: []);
}

class LoadedDetailsMoviesState extends DetailsMovieState {
  LoadedDetailsMoviesState(
      MovieDetailsResponse movieDetailsResponse,
      List<String?> genresOfSimilarMovie)
      : super(
            movieDetailsResponse: movieDetailsResponse,
            genresOfSimilarMovie: genresOfSimilarMovie);
}
