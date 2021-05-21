part of 'details_movie_bloc.dart';

abstract class DetailsMovieState {
  final ListPhotoResponse? photos;
  final MovieDetailsResponse movieDetailsResponse;
  final CreditsResponse creditsResponse;
  final ListResponse listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  DetailsMovieState(
      {this.photos,
      required this.movieDetailsResponse,
      required this.creditsResponse,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie});

  @override
  List get props => [];
}

class DetailsMovieInitState extends DetailsMovieState {
  DetailsMovieInitState()
      : super(
            photos: ListPhotoResponse(),
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
            creditsResponse: CreditsResponse(id: 0, cast: [], crew: []),
            listResponseSimilarMovies: ListResponse(
                page: 0, totalPages: 0, totalResults: 0, movies: []),
            genresOfSimilarMovie: []);
}

class DetailsLoadingState extends DetailsMovieState {
  DetailsLoadingState()
      : super(
            photos: ListPhotoResponse(),
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
            creditsResponse: CreditsResponse(id: 0, cast: [], crew: []),
            listResponseSimilarMovies: ListResponse(
                page: 0, totalPages: 0, totalResults: 0, movies: []),
            genresOfSimilarMovie: []);
}

class LoadedDetailsMoviesState extends DetailsMovieState {
  LoadedDetailsMoviesState(
      ListPhotoResponse? photos,
      MovieDetailsResponse movieDetailsResponse,
      CreditsResponse creditsResponse,
      ListResponse listResponseSimilarMovies,
      List<String?> genresOfSimilarMovie)
      : super(
            photos: photos,
            movieDetailsResponse: movieDetailsResponse,
            creditsResponse: creditsResponse,
            listResponseSimilarMovies: listResponseSimilarMovies,
            genresOfSimilarMovie: genresOfSimilarMovie);
}
