import 'package:equatable/equatable.dart';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
//REVIEW this will cause issues with your state management. Since you don't override it for any decendants.
//REVIEW Could you explain what is the purpose of using it in
}

class MovieInitState extends MovieState {}

class LoadingState extends MovieState {}

class LoadedTrendingMoviesState extends MovieState {
  final List<int> numbers;
  final ListResponse response;
  final List<String?> genres;
  final List<String?> tagline;
  final List<ListPhotoResponse> listPhotosResponse;
  final List<MovieDetailsResponse> listDetailsResponse;
  final List<CreditsResponse> creditsResponse;
  final List<ListResponse> responseSimilarMovies;

  // final List<List<String?>> listGenresOfSimilarMovies;

  //REVIEW prefer use of named parameters and copyWith to create new state
  LoadedTrendingMoviesState(
      this.numbers,
      this.response,
      this.genres,
      this.tagline,
      this.listPhotosResponse,
      this.listDetailsResponse,
      this.creditsResponse,
      this.responseSimilarMovies
      // , this.listGenresOfSimilarMovies
      );
}

//REVIEW this state is mutually exclusive from the LoadedTrendingMoviesState
class LoadedUpcomingMoviesState extends MovieState {
  final ListResponse response;
  final List<String?> genres;

  LoadedUpcomingMoviesState(this.response, this.genres);
}

class LoadedPhotosState extends MovieState {
  final List<ListPhotoResponse> response;

  LoadedPhotosState(this.response);
}
