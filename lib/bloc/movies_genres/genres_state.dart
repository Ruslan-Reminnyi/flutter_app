part of 'genres_bloc.dart';

class LoadingState {}

class GenresState {
  final ListGenresResponse allApiGenres;
  final String? currentGenres;
  final bool loading;

  GenresState(
      {required this.allApiGenres,
      required this.currentGenres,
      required this.loading});

  GenresState copyWith({allApiGenres, currentGenres, tagline, loading}) {
    return GenresState(
        allApiGenres: allApiGenres ?? this.allApiGenres,
        currentGenres: currentGenres ?? this.currentGenres,
        loading: loading ?? this.loading);
  }
}
