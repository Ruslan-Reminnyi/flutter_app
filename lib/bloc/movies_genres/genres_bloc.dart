import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'genres_event.dart';

part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  GenresBloc() : super(GenresState(allApiGenres: [], loading: true)) {
    on<LoadMovieGenresEvent>(_loadedGenresMovies);
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Future<void> _loadedGenresMovies(GenresEvent movieEvent, Emitter<GenresState> emit) async {
    try {
      emit(state.copyWith(loading: true));

      //REVIEW fetch it only once
      ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();

      emit(GenresState(allApiGenres: listGenresResponse.genres, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
