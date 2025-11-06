import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Api _api = Api();

  SearchBloc()
    : super(SearchState(page: 0, listMovieModel: [], loading: true)) {
    on<LoadSearchMovieEvent>(_searchMovies);
    on<LoadMoreSearchMovieEvent>(_searchMoreMovies);
  }

  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    dynamic events,
    dynamic transitionFn,
  ) {
    return events
        .debounceTime(Duration(milliseconds: 150))
        .switchMap(transitionFn);
  }

  Future<void> _searchMovies(
    SearchEvent movieEvent,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (movieEvent.query.isEmpty) {
        emit(SearchState(page: 0, listMovieModel: [], loading: false));
      }

      emit(state.copyWith(loading: true));

      ListResponse listResponse = await _api.searchMovies(movieEvent.query, 1);

      emit(
        SearchState(
          page: listResponse.page,
          listMovieModel: listResponse.movies,
          loading: false,
        ),
      );
    } catch (e) {
      List<MovieModel>? listMovieModel = [];

      emit(state.copyWith(listMovieModel: listMovieModel, loading: false));
    }
  }

  Future<void> _searchMoreMovies(
    SearchEvent movieEvent,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (movieEvent.query.isEmpty) {
        emit(SearchState(page: 0, listMovieModel: [], loading: false));
      }

      int page = (state.page ?? 2) + 1;

      ListResponse listResponse = await _api.searchMovies(
        movieEvent.query,
        page,
      );

      emit(
        state.copyWith(
          page: page,
          listMovieModel: state.listMovieModel
            ?..addAll(listResponse.movies ?? []),
          loading: false,
        ),
      );
    } catch (e) {
      List<MovieModel>? listMovieModel = [];

      emit(state.copyWith(listMovieModel: listMovieModel, loading: false));
    }
  }
}
