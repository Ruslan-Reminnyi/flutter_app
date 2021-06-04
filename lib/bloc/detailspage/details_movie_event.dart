part of 'details_movie_bloc.dart';

class DetailsMovieEvent {
  final int id;

  DetailsMovieEvent({this.id = 1});
}

class LoadDetailsPageEvent extends DetailsMovieEvent {
  LoadDetailsPageEvent({int id = 1}) : super(id: id);
}

class LoadMoreDetailsPageEvent extends DetailsMovieEvent {}
