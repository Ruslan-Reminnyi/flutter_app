part of 'auth_bloc.dart';

class LoadingState {}

class AuthState {
  final String? token;
  final String? sessionId;
  final int? page;
  final List<MovieModel>? listMovieModel;
  final FavoriteResponse? response;
  final bool loading;

  AuthState(
      {required this.loading,
      required this.sessionId,
      required this.page,
      required this.listMovieModel,
      required this.response,
      required this.token});

  AuthState copyWith(
      {token, sessionId, page, listMovieModel, response, loading}) {
    return AuthState(
        token: token,
        sessionId: sessionId,
        page: page,
        listMovieModel: listMovieModel,
        response: response,
        loading: loading ?? this.loading);
  }
}
