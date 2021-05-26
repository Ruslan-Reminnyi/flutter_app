part of 'trending_movie_bloc.dart';

abstract class TrendingMovieEvent {
  final int? pageNumber;

  TrendingMovieEvent({required this.pageNumber});
}

//REVIEW Event should be a verb.
// Noun in the past tense is the correct way to describe event but in bloc it's triggering actions
class LoadTrendingPageEvent extends TrendingMovieEvent {
  LoadTrendingPageEvent(int? pageNumber) : super(pageNumber: pageNumber);
}
