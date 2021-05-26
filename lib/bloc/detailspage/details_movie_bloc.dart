import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_movie_event.dart';

part 'details_movie_state.dart';

class DetailsMovieBloc extends Bloc<DetailsMovieEvent, DetailsMovieState> {
  final Api _api = Api();

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

    yield LoadedDetailsMoviesState(
        movieDetailsResponse,
        _getGenresForSimilarMovies(
            movieDetailsResponse.listSimilarMovies, allGenresList));
  }

  List<String?> _getGenresForSimilarMovies(
      ListResponse? listResponse, List<MovieGenresModel>? allGenresList) {
    List<String?> genresNames = [];

    List<MovieModel>? listMovies = listResponse?.movies;

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
