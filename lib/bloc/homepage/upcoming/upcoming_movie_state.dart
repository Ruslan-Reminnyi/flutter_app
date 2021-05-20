part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieState {
  final ListResponse response;
  final List<String?> genres;

  UpcomingMovieState({required this.response, required this.genres});

  @override
  List get props => [];
}

class UpcomingMovieInitState extends UpcomingMovieState {
  UpcomingMovieInitState()
      : super(
            genres: [],
            response: ListResponse(
                page: 0, totalPages: 0, totalResults: 0, movies: []));
}

class UpcomingLoadingState extends UpcomingMovieState {
  UpcomingLoadingState()
      : super(
            genres: [],
            response: ListResponse(
                page: 0, totalPages: 0, totalResults: 0, movies: []));
}

//REVIEW this state is mutually exclusive from the LoadedTrendingMoviesState
class LoadedUpcomingMoviesState extends UpcomingMovieState {
  LoadedUpcomingMoviesState(ListResponse response, List<String?> genres)
      : super(response: response, genres: genres);
}
