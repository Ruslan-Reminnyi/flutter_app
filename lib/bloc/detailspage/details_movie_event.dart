part of 'details_movie_bloc.dart';

class DetailsMovieEvent {
  final int? id;

  DetailsMovieEvent({this.id});

}

class LoadDetailsPageEvent extends DetailsMovieEvent {

  LoadDetailsPageEvent({int? id}) : super(id: id);
}

class LoadMoreDetailsPageEvent extends DetailsMovieEvent {}
