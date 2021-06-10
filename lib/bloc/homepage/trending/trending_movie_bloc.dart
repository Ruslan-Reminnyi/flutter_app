import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trending_movie_event.dart';

part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  TrendingMovieBloc()
      : super(TrendingMovieState(page: 0, listMovieModel: [], loading: true));

  @override
  Stream<TrendingMovieState> mapEventToState(TrendingMovieEvent event) async* {
    if (event is LoadTrendingMoviesEvent) {
      yield* _loadedTrendingMovies(event);
    }
    if (event is LoadMoreTrendingMoviesEvent) {
      yield* _loadedMoreTrendingMovies(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<TrendingMovieState> _loadedTrendingMovies(
      TrendingMovieEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      ListResponse listResponseTrending =
          await _api.getTrendingMovies((state.page ?? 1) + 1);

      yield TrendingMovieState(
          page: listResponseTrending.page,
          listMovieModel: listResponseTrending.movies,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<TrendingMovieState> _loadedMoreTrendingMovies(
      TrendingMovieEvent movieEvent) async* {
    try {
      ListResponse listResponseTrending =
          await _api.getTrendingMovies((state.page ?? 1) + 1);

      List<MovieModel>? listMovieModel = state.listMovieModel
        ?..addAll(listResponseTrending.movies ?? []);

      yield state.copyWith(
          page: listResponseTrending.page,
          listMovieModel: listMovieModel,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }
}
