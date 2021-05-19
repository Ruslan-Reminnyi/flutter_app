import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/product_companies_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_movie_event.dart';
part 'details_movie_state.dart';

class DetailsMovieBloc extends Bloc<DetailsMovieEvent, DetailsMovieState> {

  Api _api = Api();

  DetailsMovieBloc() : super(DetailsMovieInitState());

  @override
  Stream<DetailsMovieState> mapEventToState(DetailsMovieEvent event) async* {

    if (event is LoadDetailsPageEvent) {
      yield* _loadedDetails(event);
    }

  }

  Stream<DetailsMovieState> _loadedDetails(DetailsMovieEvent movieEvent) async* {

    yield DetailsLoadingState();

    ListResponse listResponseTrending = await _api.getTrendingMovies(1);

    MovieModel? movieModel = listResponseTrending.movies?.firstWhere((element) => element.id == movieEvent.id);

    ListGenresResponse listGenresResponse = await _api.getGenresOfMovies();
    List<MovieGenresModel>? allGenresList = listGenresResponse.genres;

    ListPhotoResponse? photoResponse = await _api.getPhotosOfMovies(movieEvent.id);

    MovieDetailsResponse detailsResponse = await _api.getDetailsOfMovies(movieEvent.id);

    CreditsResponse creditsResponse = await _api.getCreditsOfMovies(movieEvent.id);

    ListResponse currentListSimilarMovies = await _api.getSimilarMovies(movieEvent.id);

    yield LoadedDetailsMoviesState(
      movieModel,
      _getGenres(movieModel, allGenresList),
      photoResponse,
      detailsResponse,
      creditsResponse,
      currentListSimilarMovies,
    );

  }

  String? _getGenres(MovieModel? model, List<MovieGenresModel>? allGenresList) {
    final genresOfCurrentMovie = model?.genres;

    var names = allGenresList
        ?.where((item) => genresOfCurrentMovie!.contains(item.id))
        .map((e) => e.name)
        .join(", ");

    return names;
  }

}