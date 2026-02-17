part of 'search_bloc.dart';

sealed class SearchEvent {
  String query;

  SearchEvent(this.query);
}

class LoadSearchMovieEvent extends SearchEvent {
  LoadSearchMovieEvent(super.query);
}

class LoadMoreSearchMovieEvent extends SearchEvent {
  LoadMoreSearchMovieEvent(super.query);
}
