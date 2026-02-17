part of 'upcoming_movie_bloc.dart';

sealed class UpcomingMovieEvent {}

class LoadUpcomingMoviesEvent extends UpcomingMovieEvent {}

class LoadMoreUpcomingMoviesEvent extends UpcomingMovieEvent {}
