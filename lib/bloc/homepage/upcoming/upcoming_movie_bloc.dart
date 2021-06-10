import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_movie_event.dart';

part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final Api _api = Api();

  //REVIEW don't store any intermidiate fields in bloc. They must be part of state

  UpcomingMovieBloc()
      : super(UpcomingMovieState(loading: false, listMovieModel: [], page: 0));

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
          await _api.getUpcomingMovies((state.page ?? 1) + 1);

      yield UpcomingMovieState(
          page: listResponseUpcoming.page,
          listMovieModel: listResponseUpcoming.movies,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<UpcomingMovieState> _loadedMoreUpcomingMovies(
      UpcomingMovieEvent movieEvent) async* {
    try {
      ListResponse listResponseUpcoming =
          await _api.getUpcomingMovies((state.page ?? 1) + 1);

      List<MovieModel>? listMovieModel = state.listMovieModel
        ?..addAll(listResponseUpcoming.movies ?? []);

      yield state.copyWith(
          page: listResponseUpcoming.page,
          listMovieModel: listMovieModel,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }
}
