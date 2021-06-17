part of 'auth_bloc.dart';

class LoadingState {}

class AuthState {
  final String? token;
  final String? sessionId;
  final bool loading;

  AuthState(
      {required this.loading,
        required this.sessionId,
        required this.token});

  AuthState copyWith({token, sessionId, loading}) {
    return AuthState(
        token: token,
        sessionId: sessionId,
        loading: loading ?? this.loading);
  }
}
