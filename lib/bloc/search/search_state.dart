part of 'search_bloc.dart';

class SearchState {
  final int? page;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  SearchState({
    required this.listMovieModel,
    required this.loading,
    required this.page,
  });

  SearchState copyWith({
    int? page,
    List<MovieModel>? listMovieModel,
    bool? loading,
  }) {
    return SearchState(
      listMovieModel: listMovieModel ?? this.listMovieModel,
      page: page,
      loading: loading ?? this.loading,
    );
  }
}
