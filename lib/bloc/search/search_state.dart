part of 'search_bloc.dart';

class LoadingState {}

class SearchState {
  final int? page;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  SearchState({required this.listMovieModel, required this.loading, required this.page});

  SearchState copyWith({page, listMovieModel, loading}) {
    return SearchState(
        listMovieModel: listMovieModel ?? this.listMovieModel,
        page: page,
        loading: loading ?? this.loading);
  }
}
