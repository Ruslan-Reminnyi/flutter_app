import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'genres_event.dart';

part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final Api _api = Api();

  GenresBloc() : super(GenresState(allApiGenres: [], loading: true)) {
    on<LoadMovieGenresEvent>(_loadedGenresMovies);
  }

  Future<void> _loadedGenresMovies(
    GenresEvent movieEvent,
    Emitter<GenresState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true));

      ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

      emit(
        GenresState(allApiGenres: listGenresResponse.genres, loading: false),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
