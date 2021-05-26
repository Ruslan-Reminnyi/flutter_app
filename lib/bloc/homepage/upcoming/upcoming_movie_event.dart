part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieEvent {
  final int? pageNumber;

  UpcomingMovieEvent({required this.pageNumber});
}

class LoadUpcomingPageEvent extends UpcomingMovieEvent {
  LoadUpcomingPageEvent(int? pageNumber) : super(pageNumber: pageNumber);
}
