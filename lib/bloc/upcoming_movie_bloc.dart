import 'package:flutter_app/bloc/movie_event.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';

class UpcomingMovieBloc extends Bloc<MovieEvent, MovieState> {

  Api _api = Api();
  late ListResponse listResponseUpcoming;
  late ListGenresResponse listGenresResponse;

  UpcomingMovieBloc() : super(MovieInitState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {

    if(event is LoadedUpcomingPageEvent) {
      yield* _loadedUpcomingMovies(event);
    }

  }

  Stream<MovieState> _loadedUpcomingMovies(MovieEvent movieEvent) async* {

    yield LoadingState();

    listResponseUpcoming = await _api.getUpcomingMovies(1);

    listGenresResponse = await _api.getGenresOfMovies();

    yield LoadedUpcomingMoviesState(
      listResponseUpcoming,
      _getGenres(listResponseUpcoming),
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

}