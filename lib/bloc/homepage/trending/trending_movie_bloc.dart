import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';
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
            listMovieModel: [],
            allApiGenres: ListGenresResponse(),
            currentGenres: [],
            loading: true));

  @override
  Stream<TrendingMovieState> mapEventToState(TrendingMovieEvent event) async* {
    if (event is LoadTrendingMoviesEvent) {
      yield* _loadedTrendingMovies(event);
    }
    if (event is LoadMoreTrendingMoviesEvent) {
      yield* _loadedMoreTrendingMovies(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<TrendingMovieState> _loadedTrendingMovies(
      TrendingMovieEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      ListResponse listResponseTrending =
          await _api.getTrendingMovies((state.response.page ?? 1) + 1);

      //REVIEW fetch it only once
      ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

      List<MovieGenresModel>? allGenresList = listGenresResponse.genres;

      yield TrendingMovieState(
          numbers: _getListOfNumbersOfTheMovies(listResponseTrending),
          response: listResponseTrending,
          listMovieModel: listResponseTrending.movies,
          allApiGenres: listGenresResponse,
          currentGenres: _getGenres(listResponseTrending, allGenresList),
          loading: false);
    } catch (e) {
      yield TrendingMovieState(
          numbers: [],
          response:
              ListResponse(page: 0, movies: [], totalPages: 1, totalResults: 1),
          listMovieModel: [],
          allApiGenres: ListGenresResponse(),
          currentGenres: [],
          loading: false);
    }
  }

  Stream<TrendingMovieState> _loadedMoreTrendingMovies(
      TrendingMovieEvent movieEvent) async* {
    try {
      ListResponse listResponseTrending =
          await _api.getTrendingMovies((state.response.page ?? 1) + 1);

      List<MovieGenresModel>? allGenresList = state.allApiGenres.genres;

      List<int> numbers = state.numbers
        ..addAll(_getListOfNumbersOfTheMovies(listResponseTrending));

      List<MovieModel>? listMovieModel = state.listMovieModel
        ?..addAll(listResponseTrending.movies ?? []);

      List<String?> currentGenres = state.currentGenres
        ..addAll(_getGenres(listResponseTrending, allGenresList));

      yield state.copyWith(
          numbers: numbers,
          response: listResponseTrending,
          listMovieModel: listMovieModel,
          currentGenres: currentGenres,
          loading: false);
    } catch (e) {
      yield TrendingMovieState(
          numbers: [],
          response:
              ListResponse(page: 0, movies: [], totalPages: 1, totalResults: 1),
          listMovieModel: [],
          allApiGenres: ListGenresResponse(),
          currentGenres: [],
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

  String? genresToList(
      MovieModel model, List<MovieGenresModel>? allGenresList) {
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
}
