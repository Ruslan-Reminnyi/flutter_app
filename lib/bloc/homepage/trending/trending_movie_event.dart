part of 'trending_movie_bloc.dart';

sealed class TrendingMovieEvent {}

class LoadTrendingMoviesEvent extends TrendingMovieEvent {}

class LoadMoreTrendingMoviesEvent extends TrendingMovieEvent {}
