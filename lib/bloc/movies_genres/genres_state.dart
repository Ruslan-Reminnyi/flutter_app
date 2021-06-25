part of 'genres_bloc.dart';

class GenresState {
  final List<MovieGenresModel>? allApiGenres;
  final bool loading;

  GenresState({required this.allApiGenres, required this.loading});

  GenresState copyWith({allApiGenres, currentGenres, loading}) {
    return GenresState(
        allApiGenres: allApiGenres ?? this.allApiGenres,
        loading: loading ?? this.loading);
  }
}
