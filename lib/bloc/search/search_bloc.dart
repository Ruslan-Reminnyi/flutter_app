import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  SearchBloc() : super(SearchState(page: 0, listMovieModel: [], loading: true));

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is LoadSearchMovieEvent) {
      yield* _searchMovies(event);
    }
    if (event is LoadMoreSearchMovieEvent) {
      yield* _searchMoreMovies(event);
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      events, transitionFn) {
    return events
        .debounceTime(Duration(milliseconds: 150))
        .switchMap(transitionFn);
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<SearchState> _searchMovies(SearchEvent movieEvent) async* {
    try {
      if (movieEvent.query.isEmpty) {
        yield SearchState(page: 0, listMovieModel: [], loading: false);
      }

      yield state.copyWith(loading: true);

      ListResponse listResponse = await _api.searchMovies(movieEvent.query, 1);

      yield SearchState(
          page: listResponse.page,
          listMovieModel: listResponse.movies,
          loading: false);
    } catch (e) {
      List<MovieModel>? listMovieModel = [];

      yield state.copyWith(listMovieModel: listMovieModel, loading: false);
    }
  }

  Stream<SearchState> _searchMoreMovies(SearchEvent movieEvent) async* {
    try {
      if (movieEvent.query.isEmpty) {
        yield SearchState(page: 0, listMovieModel: [], loading: false);
      }

      int page = (state.page ?? 2) + 1;

      ListResponse listResponse =
          await _api.searchMovies(movieEvent.query, page);

      yield state.copyWith(
          page: page,
          listMovieModel: state.listMovieModel
            ?..addAll(listResponse.movies ?? []),
          loading: false);
    } catch (e) {
      List<MovieModel>? listMovieModel = [];

      yield state.copyWith(listMovieModel: listMovieModel, loading: false);
    }
  }
}
