part of 'details_movie_bloc.dart';

class DetailsMovieEvent {
  final int id;

  DetailsMovieEvent({required this.id});
}

class LoadDetailsPageEvent extends DetailsMovieEvent {
  LoadDetailsPageEvent({required super.id});
}

class LoadMoreDetailsPageEvent extends DetailsMovieEvent {
  LoadMoreDetailsPageEvent({required super.id});
}
