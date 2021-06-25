part of 'auth_bloc.dart';

abstract class AuthEvent {}

class GetTokenEvent extends AuthEvent {}

class GetSessionIdEvent extends AuthEvent {}

class GetAccountEvent extends AuthEvent {}

class GetFavoriteMoviesEvent extends AuthEvent {}

class GetMoreFavoriteMoviesEvent extends AuthEvent {}

class MarkAsFavoriteEvent extends AuthEvent {
  FavoriteRequest request;

  MarkAsFavoriteEvent({required this.request});
}
