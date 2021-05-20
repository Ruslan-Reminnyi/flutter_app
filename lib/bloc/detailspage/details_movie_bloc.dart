import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_photo_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_movie_event.dart';

part 'details_movie_state.dart';

class DetailsMovieBloc extends Bloc<DetailsMovieEvent, DetailsMovieState> {
  Api _api = Api();

  DetailsMovieBloc() : super(DetailsMovieInitState());

  @override
  Stream<DetailsMovieState> mapEventToState(DetailsMovieEvent event) async* {
    if (event is LoadDetailsPageEvent) {
      yield* _loadedDetails(event);
    }
  }

  Stream<DetailsMovieState> _loadedDetails(
      DetailsMovieEvent movieEvent) async* {
    yield DetailsLoadingState();

    MovieDetailsResponse movieDetailsResponse =
        await _api.getDetailsOfMovies(movieEvent.id);

    ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();
    List<MovieGenresModel>? allGenresList = listGenresResponse.genres;

    ListPhotoResponse? photoResponse =
        await _api.getPhotosOfMovies(movieEvent.id);

    CreditsResponse creditsResponse =
        await _api.getCreditsOfMovies(movieEvent.id);

    ListResponse currentListSimilarMovies =
        await _api.getSimilarMovies(movieEvent.id);

    yield LoadedDetailsMoviesState(
        _getGenres(movieDetailsResponse, allGenresList),
        photoResponse,
        movieDetailsResponse,
        creditsResponse,
        currentListSimilarMovies,
        _getGenresForSimilarMovies(currentListSimilarMovies, allGenresList));
  }

  String? _getGenres(MovieDetailsResponse movieDetailsResponse,
      List<MovieGenresModel>? allGenresList) {
    final genresIds = movieDetailsResponse.genres?.map((e) => e.id);

    var names = allGenresList
        ?.where((item) => genresIds!.contains(item.id))
        .map((e) => e.name)
        .join(", ");

    return names;
  }

  List<String?> _getGenresForSimilarMovies(
      ListResponse listResponse, List<MovieGenresModel>? allGenresList) {
    List<String?> genresNames = [];

    List<MovieModel>? listMovies = listResponse.movies;

    listMovies?.forEach((element) {
      genresNames.add(genresToList(element, allGenresList));
    });

    return genresNames;
  }

  String? genresToList(
      MovieModel model, List<MovieGenresModel>? allGenresList) {
    final genresOfCurrentMovie = model.genres;

    var names = allGenresList
        ?.where((item) => genresOfCurrentMovie!.contains(item.id))
        .map((e) => e.name)
        .join(", ");

    return names;
  }
}
