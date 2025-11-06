import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trending_movie_event.dart';

part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final Api _api = Api();

  TrendingMovieBloc()
    : super(TrendingMovieState(page: 0, listMovieModel: [], loading: true)) {
    on<LoadTrendingMoviesEvent>(_loadedTrendingMovies);
    on<LoadMoreTrendingMoviesEvent>(_loadedMoreTrendingMovies);
  }

  Future<void> _loadedTrendingMovies(
    TrendingMovieEvent movieEvent,
    Emitter<TrendingMovieState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true));

      ListResponse listResponseTrending = await _api.getTrendingMovies(
        (state.page ?? 1) + 1,
      );

      emit(
        TrendingMovieState(
          page: listResponseTrending.page,
          listMovieModel: listResponseTrending.movies,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _loadedMoreTrendingMovies(
    TrendingMovieEvent movieEvent,
    Emitter<TrendingMovieState> emit,
  ) async {
    try {
      ListResponse listResponseTrending = await _api.getTrendingMovies(
        (state.page ?? 1) + 1,
      );

      List<MovieModel>? listMovieModel = state.listMovieModel
        ?..addAll(listResponseTrending.movies ?? []);

      emit(
        state.copyWith(
          page: listResponseTrending.page,
          listMovieModel: listMovieModel,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
