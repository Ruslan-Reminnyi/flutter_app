part of 'auth_bloc.dart';

class AuthEvent {
  FavoriteRequest request;

  AuthEvent({required this.request});
}

class GetTokenEvent extends AuthEvent {
  GetTokenEvent(FavoriteRequest request) : super(request: request);
}

class GetSessionIdEvent extends AuthEvent {
  GetSessionIdEvent(FavoriteRequest request) : super(request: request);
}

class GetFavoriteMoviesEvent extends AuthEvent {
  GetFavoriteMoviesEvent(FavoriteRequest request) : super(request: request);
}

class GetMoreFavoriteMoviesEvent extends AuthEvent {
  GetMoreFavoriteMoviesEvent(FavoriteRequest request) : super(request: request);
}

class MarkAsFavoriteEvent extends AuthEvent {
  MarkAsFavoriteEvent(FavoriteRequest request) : super(request: request);
}
