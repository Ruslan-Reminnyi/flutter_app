import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_movie_event.dart';

part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final Api _api = Api();

  //REVIEW don't store any intermidiate fields in bloc. They must be part of state

  UpcomingMovieBloc()
      : super(UpcomingMovieState(
            loading: false,
            currentGenres: [],
            listMovieModel: [],
            response: ListResponse(
                page: 0, totalPages: 0, totalResults: 0, movies: [])));

  @override
  Stream<UpcomingMovieState> mapEventToState(UpcomingMovieEvent event) async* {
    if (event is LoadUpcomingMoviesEvent) {
      yield* _loadedUpcomingMovies(event);
    }
    if (event is LoadMoreUpcomingMoviesEvent) {
      yield* _loadedMoreUpcomingMovies(event);
    }
  }

  Stream<UpcomingMovieState> _loadedUpcomingMovies(
      UpcomingMovieEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      ListResponse listResponseUpcoming =
          await _api.getUpcomingMovies((state.response.page ?? 1) + 1);

      List<String?> listGenres = await _getGenres(listResponseUpcoming);

      yield UpcomingMovieState(
          response: listResponseUpcoming,
          listMovieModel: listResponseUpcoming.movies,
          currentGenres: listGenres,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<UpcomingMovieState> _loadedMoreUpcomingMovies(
      UpcomingMovieEvent movieEvent) async* {
    try {
      ListResponse listResponseUpcoming =
          await _api.getUpcomingMovies((state.response.page ?? 1) + 1);

      List<MovieModel>? listMovieModel = state.listMovieModel
        ?..addAll(listResponseUpcoming.movies ?? []);

      List<String?> listGenres = await _getGenres(listResponseUpcoming);

      List<String?> currentGenres = state.currentGenres..addAll(listGenres);

      yield state.copyWith(
          response: listResponseUpcoming,
          listMovieModel: listMovieModel,
          currentGenres: currentGenres,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Future<List<String?>> _getGenres(ListResponse listResponse) async {
    List<String?> genresNames = [];
    ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

    for (var genres in listResponse.movies ?? []) {
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
