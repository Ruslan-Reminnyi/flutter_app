import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_movie_event.dart';

part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final Api _api = Api();

  UpcomingMovieBloc()
    : super(UpcomingMovieState(loading: false, listMovieModel: [], page: 0)) {
    on<LoadUpcomingMoviesEvent>(_loadedUpcomingMovies);
    on<LoadMoreUpcomingMoviesEvent>(_loadedMoreUpcomingMovies);
  }

  Future<void> _loadedUpcomingMovies(
    UpcomingMovieEvent movieEvent,
    Emitter<UpcomingMovieState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true));

      ListResponse listResponseUpcoming = await _api.getUpcomingMovies(
        (state.page ?? 1) + 1,
      );

      emit(
        UpcomingMovieState(
          page: listResponseUpcoming.page,
          listMovieModel: listResponseUpcoming.movies,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _loadedMoreUpcomingMovies(
    UpcomingMovieEvent movieEvent,
    Emitter<UpcomingMovieState> emit,
  ) async {
    try {
      ListResponse listResponseUpcoming = await _api.getUpcomingMovies(
        (state.page ?? 1) + 1,
      );

      List<MovieModel>? listMovieModel = state.listMovieModel
        ?..addAll(listResponseUpcoming.movies ?? []);

      emit(
        state.copyWith(
          page: listResponseUpcoming.page,
          listMovieModel: listMovieModel,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
