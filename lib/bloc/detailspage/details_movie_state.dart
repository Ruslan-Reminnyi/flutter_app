part of 'details_movie_bloc.dart';

abstract class DetailsMovieState {

  final MovieModel? movieModel;
  final String? genres;
  final ListPhotoResponse? photos;
  final MovieDetailsResponse movieDetailsResponse;
  final CreditsResponse creditsResponse;
  final ListResponse listResponseSimilarMovies;

  //REVIEW prefer use of named parameters and copyWith to create new state
  DetailsMovieState({
    required this.movieModel,
    required this.genres,
    required this.photos,
    required this.movieDetailsResponse,
    required this.creditsResponse,
    required this.listResponseSimilarMovies
  });

  @override
  List get props => [];
}

class DetailsMovieInitState extends DetailsMovieState {
  DetailsMovieInitState() : super(
      movieModel: MovieModel(id: 0, genres: [], backdrop_path: '',
          overview: '', original_name: '', original_title: '',
      country: '', poster_path: '', rating: 0.0, run_time: 0),
      genres: '',
      photos: ListPhotoResponse(),
      movieDetailsResponse: MovieDetailsResponse(id: 0, tagline: '', imdb_id: '',
          production_companies: [], runtime: 0),
      creditsResponse: CreditsResponse(id: 0, cast: [], crew: []),
      listResponseSimilarMovies: ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: [])
  );
}

class DetailsLoadingState extends DetailsMovieState {
  DetailsLoadingState() : super(
      movieModel: MovieModel(id: 0, genres: [], backdrop_path: '',
          overview: '', original_name: '', original_title: '',
          country: '', poster_path: '', rating: 0.0, run_time: 0),
      genres: '',
      photos: ListPhotoResponse(),
      movieDetailsResponse: MovieDetailsResponse(id: 0, tagline: '', imdb_id: '',
          production_companies: [], runtime: 0),
      creditsResponse: CreditsResponse(id: 0, cast: [], crew: []),
      listResponseSimilarMovies: ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: [])
  );
}

class LoadedDetailsMoviesState extends DetailsMovieState {
  LoadedDetailsMoviesState(
      MovieModel? movieModel,
      String? genres,
      ListPhotoResponse? photos,
      MovieDetailsResponse movieDetailsResponse,
      CreditsResponse creditsResponse,
      ListResponse listResponseSimilarMovies
      ) : super(
      movieModel: movieModel,
      genres: genres,
      photos: photos,
      movieDetailsResponse: movieDetailsResponse,
      creditsResponse: creditsResponse,
      listResponseSimilarMovies: listResponseSimilarMovies
  );
}
