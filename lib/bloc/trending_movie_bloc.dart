import 'package:flutter_app/bloc/movie_event.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';

class TrendingMovieBloc extends Bloc<MovieEvent, MovieState> {
  Api _api = Api();
  //REVIEW remove all fields with state from Bloc. They must be placed in state
  late ListResponse listResponseTrending;
  late ListGenresResponse listGenresResponse;
  late List<MovieGenresModel>? allGenresList;
  late List<ListPhotoResponse> listPhotoResponse = [];
  final List<MovieDetailsResponse> listDetailsResponse = [];
  final List<CreditsResponse> creditsResponse = [];
  late List<ListResponse> listResponseSimilar = [];
  late List<List<String?>> listGenresOfSimilarMovies = [];

  TrendingMovieBloc() : super(MovieInitState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is LoadedTrendingPageEvent) {
      yield* _loadedTrendingMovies(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<MovieState> _loadedTrendingMovies(MovieEvent movieEvent) async* {
    yield LoadingState();

    listResponseTrending = await _api.getTrendingMovies(1);

    List<String?> listTaglines = [];

    List<int?>? listIdTaglines =
        listResponseTrending?.movies?.map((e) => e.id).toList();
    // listTaglines.addAll(listIdTaglines!.map((element) { getCurrentTagline(element); }));
    for (int? id in listIdTaglines!) {
      //REVIEW why are you loading details right away for every single movie?
      MovieDetailsResponse currentTagline = await _api.getDetailsOfMovies(id);
      listTaglines.add(currentTagline.tagline);

      ListPhotoResponse currentPhotoResponse = await _api.getPhotosOfMovies(id);
      listPhotoResponse.add(currentPhotoResponse);

      //REVIEW why are you fetching details seconds time?
      MovieDetailsResponse detailsResponse = await _api.getDetailsOfMovies(id);
      listDetailsResponse.add(detailsResponse);

      CreditsResponse currentCreditsResponse =
          await _api.getCreditsOfMovies(id);
      creditsResponse.add(currentCreditsResponse);

      ListResponse currentListSimilarMovies = await _api.getSimilarMovies(id);
      listResponseSimilar.add(currentListSimilarMovies);
      // listGenresOfSimilarMovies.add(_getGenres(currentListSimilarMovies));

    }

    //REVIEW fetch it only once
    listGenresResponse = await _api.getGenresOfMovies();

    allGenresList = listGenresResponse?.genres;

    yield LoadedTrendingMoviesState(
      _getListOfNumbersOfTheMovies(),
      listResponseTrending,
      _getGenres(listResponseTrending),
      listTaglines,
      listPhotoResponse,
      listDetailsResponse,
      creditsResponse,
      listResponseSimilar,
      // listGenresOfSimilarMovies
    );
  }

  List<String?> _getGenres(ListResponse listResponse) {
    List<String?> genresNames = [];

    List<MovieModel>? listMovies = listResponse.movies;

    listMovies?.forEach((element) {
      genresNames.add(genresToList(element));
    });

    return genresNames;
  }

  List<String?> taglinesToList() {
    List<String?> listTaglines = [];

    List<int?>? listIdTaglines =
        listResponseTrending?.movies?.map((e) => e.id).toList();

    // listTaglines.addAll(listIdTaglines!.map((element) { getCurrentTagline(element); }));
    // for (int? id in listIdTaglines!) {
    //   String currentTagline = getCurrentTagline(id);
    //   listTaglines.add(currentTagline?.tagline);
    // }

    return listTaglines;
  }

  Future<String> getCurrentTagline(int? id) async {
    MovieDetailsResponse currentTagline = await _api.getDetailsOfMovies(id);

    return currentTagline.tagline.toString();
  }

  String? genresToList(MovieModel model) {
    final genresOfCurrentMovie = model.genres;

    var names = allGenresList
        ?.where((item) => genresOfCurrentMovie!.contains(item.id))
        .map((e) => e.name)
        .join(", ");

    return names;
  }

  int _getCurrentNumberOfTheMovie(int? trendingPageNumber, int index) {
    return (trendingPageNumber! - 1) * 20 + index;
  }

  List<int> _getListOfNumbersOfTheMovies() {
    var listIndexes = List<int>.generate(20, (index) => index + 1);

    List<int> listNumbersOfTheMovies = listIndexes
        .map((e) => _getCurrentNumberOfTheMovie(listResponseTrending.page, e))
        .toList();

    return listNumbersOfTheMovies;
  }
}
