part of 'trending_movie_bloc.dart';

abstract class TrendingMovieEvent {}

class LoadTrendingPageEvent extends TrendingMovieEvent {}

class LoadMoreTrendingPageEvent extends TrendingMovieEvent {}
