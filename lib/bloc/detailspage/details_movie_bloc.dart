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
    : super(
        DetailsMovieState(
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
          loading: false,
        ),
      ) {
    on<LoadDetailsPageEvent>(_loadedDetails);
    on<LoadMoreDetailsPageEvent>(_loadedMoreSimilarMovies);
  }

  Future<void> _loadedDetails(
    LoadDetailsPageEvent movieEvent,
    Emitter<DetailsMovieState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true));

      MovieDetailsResponse movieDetailsResponse = await _api.getDetailsOfMovies(
        movieEvent.id,
      );

      emit(
        DetailsMovieState(
          movieDetailsResponse: movieDetailsResponse,
          currentPageOfSimilarMovies:
              movieDetailsResponse.listSimilarMovies?.page,
          listSimilarMovies: movieDetailsResponse.listSimilarMovies?.movies,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _loadedMoreSimilarMovies(
    DetailsMovieEvent movieEvent,
    Emitter<DetailsMovieState> emit,
  ) async {
    try {
      int? currentPageOfSimilarMovies =
          (state.currentPageOfSimilarMovies ?? 1) + 1;

      ListResponse? listSimilarMovies = await _api.getSimilarMovies(
        state.movieDetailsResponse.id ?? 1,
        currentPageOfSimilarMovies,
      );

      List<MovieModel>? currentListSimilarMovies = state.listSimilarMovies
        ?..addAll(listSimilarMovies.movies ?? []);

      emit(
        state.copyWith(
          currentPageOfSimilarMovies: currentPageOfSimilarMovies,
          listSimilarMovies: currentListSimilarMovies,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
