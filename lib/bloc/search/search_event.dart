part of 'search_bloc.dart';

class SearchEvent {
  String query;
  int page;

  SearchEvent(this.query, this.page);
}

class LoadSearchMovieEvent extends SearchEvent {
  LoadSearchMovieEvent(String query, int page) : super(query, page);

}

class LoadMoreSearchMovieEvent extends SearchEvent {
  LoadMoreSearchMovieEvent(String query, int page) : super(query, page);

}
