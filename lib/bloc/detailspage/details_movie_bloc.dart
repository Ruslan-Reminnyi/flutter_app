import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_movie_event.dart';

part 'details_movie_state.dart';

class DetailsMovieBloc extends Bloc<DetailsMovieEvent, DetailsMovieState> {
  final Api _api = Api();

  DetailsMovieBloc()
      : super(DetailsMovieState(
            movieDetailsResponse: MovieDetailsResponse(
              id: 0,
              originalTitle: '',
              tagline: '',
              overview: '',
              posterPath: '',
              genres: [],
              productionCompanies: [],
              runtime: 0,
            ),
            currentPageOfSimilarMovies: 1,
            listSimilarMovies: [],
            loading: false));

  @override
  Stream<DetailsMovieState> mapEventToState(DetailsMovieEvent event) async* {
    if (event is LoadDetailsPageEvent) {
      yield* _loadedDetails(event);
    }
    if (event is LoadMoreDetailsPageEvent) {
      yield* _loadedMoreSimilarMovies(event);
    }
  }

  Stream<DetailsMovieState> _loadedDetails(
      LoadDetailsPageEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      MovieDetailsResponse movieDetailsResponse =
          await _api.getDetailsOfMovies(movieEvent.id);

      yield DetailsMovieState(
          movieDetailsResponse: movieDetailsResponse,
          currentPageOfSimilarMovies:
              movieDetailsResponse.listSimilarMovies?.page,
          listSimilarMovies: movieDetailsResponse.listSimilarMovies?.movies,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<DetailsMovieState> _loadedMoreSimilarMovies(
      DetailsMovieEvent movieEvent) async* {
    try {
      int? currentPageOfSimilarMovies =
          (state.currentPageOfSimilarMovies ?? 1) + 1;

      ListResponse? listSimilarMovies = await _api.getSimilarMovies(
          state.movieDetailsResponse.id ?? 1, currentPageOfSimilarMovies);

      List<MovieModel>? currentListSimilarMovies = state.listSimilarMovies
        ?..addAll(listSimilarMovies.movies ?? []);

      yield state.copyWith(
          currentPageOfSimilarMovies: currentPageOfSimilarMovies,
          listSimilarMovies: currentListSimilarMovies,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }
}
