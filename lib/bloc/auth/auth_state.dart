part of 'auth_bloc.dart';

class LoadingState {}

class AuthState {
  final String? token;
  final String? sessionId;
  final int? page;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  AuthState(
      {required this.loading,
      required this.sessionId,
      required this.page,
      required this.listMovieModel,
      required this.token});

  AuthState copyWith({token, sessionId, page, listMovieModel, loading}) {
    return AuthState(
        token: token,
        sessionId: sessionId,
        page: page,
        listMovieModel: listMovieModel,
        loading: loading ?? this.loading);
  }
}
