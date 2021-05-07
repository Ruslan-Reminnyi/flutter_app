import 'package:flutter_app/bloc/movie_event.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/data/movie_details_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';

class TrendingMovieBloc extends Bloc<MovieEvent, MovieState> {

  Api _api = Api();
  late ListResponse listResponseTrending;
  late ListGenresResponse listGenresResponse;

  TrendingMovieBloc() : super(MovieInitState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {

    if(event is LoadedTrendingPageEvent) {
      yield* _loadedTrendingMovies(event);
    }

  }

  Stream<MovieState> _loadedTrendingMovies(MovieEvent movieEvent) async* {

    yield LoadingState();

    listResponseTrending = await _api.getTrendingMovies(1);

    List<int?>? listIdTaglines;
    List<String?> listTaglines = [];

    listIdTaglines = listResponseTrending?.movies?.map((e) => e.id).toList();

    for(int? id in listIdTaglines!) {
      MovieDetailsModel currentTagline = await _api.getDetailsOfMovies(id);
      listTaglines.add(currentTagline.tagline);
    }

    listGenresResponse = await _api.getGenresOfMovies();

    yield LoadedTrendingMoviesState(
        _getListOfNumbersOfTheMovies(),
        listResponseTrending,
        _getGenres(listResponseTrending),
        listTaglines
    );

  }

  List<String?> _getGenres(ListResponse listResponse) {

    List<String?> genresNames = [];

    for(var genres in listResponse.movies!) {

      final allGenresList = listGenresResponse?.genres;
      final genresOfCurrentMovie = genres.genres;

      var names = allGenresList?.where((item)
      => genresOfCurrentMovie!.contains(item.id))
          .map((e) => e.name).join(", ");

      genresNames.add(names);

    }

    return genresNames;

  }

  int _getCurrentNumberOfTheMovie(int? trendingPageNumber, int index) {
    return (trendingPageNumber! - 1) * 20 + index;
  }

  List<int> _getListOfNumbersOfTheMovies() {

    var listIndexes = List<int>.generate(20, (index) => index + 1);

    List<int> listNumbersOfTheMovies =
      listIndexes.map((e) => _getCurrentNumberOfTheMovie(listResponseTrending.page, e)).toList();

    return listNumbersOfTheMovies;

  }

}