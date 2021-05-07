import 'package:equatable/equatable.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitState extends MovieState {

}

class LoadingState extends MovieState {

}

class LoadedTrendingMoviesState extends MovieState {

  final List<int> numbers;
  final ListResponse response;
  final List<String?> genres;
  final List<String?> tagline;

  LoadedTrendingMoviesState(this.numbers, this.response, this.genres, this.tagline);

}

class LoadedUpcomingMoviesState extends MovieState {

  final ListResponse response;
  final List<String?> genres;

  LoadedUpcomingMoviesState(this.response, this.genres);

}
