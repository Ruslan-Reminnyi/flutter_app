import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trending_movie_event.dart';
part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  Api _api = Api();
  //REVIEW remove all fields with state from Bloc. They must be placed in state

  TrendingMovieBloc() : super(MovieInitState());

  @override
  Stream<TrendingMovieState> mapEventToState(TrendingMovieEvent event) async* {
    if (event is LoadTrendingPageEvent) {
      yield* _loadedTrendingMovies(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<TrendingMovieState> _loadedTrendingMovies(TrendingMovieEvent movieEvent) async* {

    yield LoadingState();

    ListResponse listResponseTrending = await _api.getTrendingMovies(1);

    List<String?> listTaglines = [];

    List<int?>? listIdTaglines =
        listResponseTrending.movies?.map((e) => e.id).toList();

    for (int? id in listIdTaglines!) {
      //REVIEW why are you loading details right away for every single movie?
      MovieDetailsResponse currentTagline = await _api.getDetailsOfMovies(id);
      listTaglines.add(currentTagline.tagline);
    }

    //REVIEW fetch it only once
    ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

    List<MovieGenresModel>? allGenresList = listGenresResponse.genres;

    yield LoadedTrendingMoviesState(
      _getListOfNumbersOfTheMovies(listResponseTrending),
      listResponseTrending,
      _getGenres(listResponseTrending, allGenresList),
      listTaglines,
    );

  }

  List<String?> _getGenres(ListResponse listResponse, List<MovieGenresModel>? allGenresList) {
    List<String?> genresNames = [];

    List<MovieModel>? listMovies = listResponse.movies;

    listMovies?.forEach((element) {
      genresNames.add(genresToList(element, allGenresList));
    });

    return genresNames;
  }

  Future<String> getCurrentTagline(int? id) async {
    MovieDetailsResponse currentTagline = await _api.getDetailsOfMovies(id);

    return currentTagline.tagline.toString();
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
}
