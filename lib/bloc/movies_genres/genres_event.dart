part of 'genres_bloc.dart';

class GenresEvent {
  final List<int>? genres;

  GenresEvent({required this.genres});
}

class LoadMovieGenresEvent extends GenresEvent {
  LoadMovieGenresEvent({required List<int>? genres}) : super(genres: genres);
}

class LoadMoreMovieGenresEvent extends GenresEvent {
  LoadMoreMovieGenresEvent({required List<int>? genres})
      : super(genres: genres);
}
