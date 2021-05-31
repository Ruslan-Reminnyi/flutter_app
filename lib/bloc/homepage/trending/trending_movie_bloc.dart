import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trending_movie_event.dart';

part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  TrendingMovieBloc()
      : super(TrendingMovieState(
            numbers: [],
            response: ListResponse(
                page: 0, movies: [], totalPages: 1, totalResults: 1),
            genres: [],
            tagline: [],
            loading: true));

  @override
  Stream<TrendingMovieState> mapEventToState(TrendingMovieEvent event) async* {
    if (event is LoadTrendingPageEvent) {
      yield* _loadedTrendingMovies(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<TrendingMovieState> _loadedTrendingMovies(
      TrendingMovieEvent movieEvent) async* {
    yield state.copyWith(loading: true);

    ListResponse listResponseTrending =
        await _api.getTrendingMovies((state.response.page ?? 0) + 1);

    //REVIEW fetch it only once
    ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

    List<MovieGenresModel>? allGenresList = listGenresResponse.genres;

    yield TrendingMovieState(
        numbers: _getListOfNumbersOfTheMovies(listResponseTrending),
        response: listResponseTrending,
        genres: _getGenres(listResponseTrending, allGenresList),
        tagline: [],
        loading: false);

    List<String?> listTaglines = [];

    List<int?>? listIdTaglines =
        listResponseTrending.movies?.map((e) => e.id).toList();

    for (int? id in listIdTaglines!) {
      //REVIEW why are you loading details right away for every single movie?
      MovieDetailsResponse currentTagline = await _api.getDetailsOfMovies(id);
      listTaglines.add(currentTagline.tagline);
    }

    yield state.copyWith(tagline: listTaglines);

    yield TrendingMovieState(
        numbers: _getListOfNumbersOfTheMovies(listResponseTrending),
        response: listResponseTrending,
        genres: _getGenres(listResponseTrending, allGenresList),
        tagline: listTaglines,
        loading: false);
  }
}

List<String?> _getGenres(
    ListResponse listResponse, List<MovieGenresModel>? allGenresList) {
  List<String?> genresNames = [];

  List<MovieModel>? listMovies = listResponse.movies;

  listMovies?.forEach((element) {
    genresNames.add(genresToList(element, allGenresList));
  });

  return genresNames;
}

String? genresToList(MovieModel model, List<MovieGenresModel>? allGenresList) {
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

List<int> _getListOfNumbersOfTheMovies(ListResponse listResponseTrending) {
  var listIndexes = List<int>.generate(20, (index) => index + 1);

  List<int> listNumbersOfTheMovies = listIndexes
      .map((e) => _getCurrentNumberOfTheMovie(listResponseTrending.page, e))
      .toList();

  return listNumbersOfTheMovies;
}
