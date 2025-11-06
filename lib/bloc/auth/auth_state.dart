part of 'auth_bloc.dart';

abstract class AuthState {}

class UnAuthorized extends AuthState {}

class AuthRequestToken extends AuthState {
  final String token;

  AuthRequestToken(this.token);
}

class Authorized extends AuthState {
  final String sessionId;
  final FavoritesList? favoritesList;
  final AccountModel? account;

  Authorized(this.sessionId, {this.favoritesList, this.account});

  AuthState copyWith({String? sessionId, FavoritesList? favoritesList, AccountModel? account}) {
    return Authorized(
      sessionId ?? this.sessionId,
      favoritesList: favoritesList ?? this.favoritesList,
      account: account ?? this.account,
    );
  }
}

class FavoritesList {
  final int? page;
  final List<MovieModel>? listMovieModel;
  final bool loading;

  FavoritesList({this.page, required this.listMovieModel, this.loading = false});
}
