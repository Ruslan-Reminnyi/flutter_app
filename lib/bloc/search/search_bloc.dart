import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<SearchState> _searchMovies(SearchEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      int page = movieEvent.page;
      ListResponse listResponse = await _api.searchMovies(
          movieEvent.query,
          page
      );

      yield SearchState(
          page: listResponse.page,
          listMovieModel: listResponse.movies,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<SearchState> _searchMoreMovies(SearchEvent movieEvent) async* {
    try {
      int page = movieEvent.page;
      ListResponse listResponse = await _api.searchMovies(
          movieEvent.query,
      page
      );

      yield SearchState(
          page: (state.page ?? 1) + 1,
          listMovieModel: state.listMovieModel
            ?..addAll(listResponse.movies ?? []),
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }
}
