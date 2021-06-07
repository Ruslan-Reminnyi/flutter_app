import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'genres_event.dart';

part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  GenresBloc()
      : super(GenresState(
            allApiGenres: ListGenresResponse(),
            currentGenres: '',
            loading: true));

  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    if (event is LoadMovieGenresEvent) {
      yield* _loadedGenresMovies(event);
    }
    if (event is LoadMoreMovieGenresEvent) {
      yield* _loadedMoreGenresMovies(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<GenresState> _loadedGenresMovies(GenresEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      //REVIEW fetch it only once
      ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

      List<MovieGenresModel>? allGenresList = listGenresResponse.genres;

      List<int>? currentGenresIds = movieEvent.genres;

      yield GenresState(
          allApiGenres: listGenresResponse,
          currentGenres: genresToList(currentGenresIds, allGenresList),
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<GenresState> _loadedMoreGenresMovies(GenresEvent movieEvent) async* {
    try {
      List<MovieGenresModel>? allGenresList = state.allApiGenres.genres;

      List<int>? currentGenresIds = movieEvent.genres;

      yield GenresState(
          allApiGenres: state.allApiGenres,
          currentGenres: genresToList(currentGenresIds, allGenresList),
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  String? genresToList(
      List<int>? currentGenresIds, List<MovieGenresModel>? allGenresList) {
    var names = allGenresList
        ?.where((item) => currentGenresIds!.contains(item.id))
        .map((e) => e.name)
        .join(", ");

    return names;
  }
}
