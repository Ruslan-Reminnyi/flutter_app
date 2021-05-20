part of 'details_movie_bloc.dart';

abstract class DetailsMovieEvent {
  final int? id;

  DetailsMovieEvent({required this.id});
}

class LoadDetailsPageEvent extends DetailsMovieEvent {
  LoadDetailsPageEvent(int? id) : super(id: id);
}
