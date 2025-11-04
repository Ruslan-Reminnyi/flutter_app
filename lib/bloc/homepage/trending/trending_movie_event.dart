part of 'trending_movie_bloc.dart';

abstract class TrendingMovieEvent {}

class LoadTrendingMoviesEvent extends TrendingMovieEvent {}

class LoadMoreTrendingMoviesEvent extends TrendingMovieEvent {}
