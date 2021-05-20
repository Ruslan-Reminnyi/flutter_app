import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_movie_event.dart';

part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  Api _api = Api();

  //REVIEW don't store any intermidiate fields in bloc. They must be part of state

  UpcomingMovieBloc() : super(UpcomingMovieInitState());

  @override
  Stream<UpcomingMovieState> mapEventToState(UpcomingMovieEvent event) async* {
    if (event is LoadUpcomingPageEvent) {
      yield* _loadedUpcomingMovies(event);
    }
  }

  Stream<UpcomingMovieState> _loadedUpcomingMovies(
      UpcomingMovieEvent movieEvent) async* {
    yield UpcomingLoadingState();

    ListResponse listResponseUpcoming = await _api.getUpcomingMovies(1);
    List<String?> listGenres = await _getGenres(listResponseUpcoming);

    yield LoadedUpcomingMoviesState(
      listResponseUpcoming,
      listGenres,
    );
  }

  Future<List<String?>> _getGenres(ListResponse listResponse) async {
    List<String?> genresNames = [];
    ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

    for (var genres in listResponse.movies!) {
      final allGenresList = listGenresResponse.genres;
      final genresOfCurrentMovie = genres.genres;

      var names = allGenresList
          ?.where((item) => genresOfCurrentMovie!.contains(item.id))
          .map((e) => e.name)
          .join(", ");

      genresNames.add(names);
    }

    return genresNames;
  }
}
