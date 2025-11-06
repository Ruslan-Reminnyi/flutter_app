import 'package:dio/dio.dart';
import 'package:flutter_app/data/account_model.dart';
import 'package:flutter_app/data/api_token.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/session_id.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Api _api = Api();

  AuthBloc() : super(UnAuthorized()) {
    on<GetTokenEvent>(_getToken);
    on<GetSessionIdEvent>(_getSessionId);
    on<GetFavoriteMoviesEvent>(_getFavoriteMovies);
    on<GetMoreFavoriteMoviesEvent>(_getMoreFavoriteMovies);
    on<MarkAsFavoriteEvent>(_markAsFavorite);
  }

  Future<void> _getToken(GetTokenEvent event, Emitter<AuthState> emit) async {
    try {
      ApiToken token = await _api.getRequestToken();

      emit(AuthRequestToken(token.token));
    } catch (e) {
      emit(UnAuthorized());
    }
  }

  Future<void> _getSessionId(
    GetSessionIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is AuthRequestToken) {
      try {
        SessionId response = await _api.getSessionId(currentState.token);

        final sessionId = response.id;

        if (sessionId == null) {
          emit(UnAuthorized());
        } else {
          emit(Authorized(sessionId));
          add(GetFavoriteMoviesEvent());
        }
      } catch (e) {
        emit(UnAuthorized());
      }
    } else {
      emit(UnAuthorized());
    }
  }

  Future<void> _getFavoriteMovies(
    GetFavoriteMoviesEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is Authorized) {
      try {
        ListResponse listResponse = await _api.getFavoriteMovies(
          currentState.sessionId,
          1,
        );

        AccountModel account = await _api.getAccount(currentState.sessionId);

        emit(
          currentState.copyWith(
            sessionId: currentState.sessionId,
            favoritesList: FavoritesList(
              page: 1,
              listMovieModel: listResponse.movies ?? [],
              loading: false,
            ),
            account: account,
          ),
        );
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          emit(UnAuthorized());
        }
      }
    }
  }

  Future<void> _getMoreFavoriteMovies(
    GetMoreFavoriteMoviesEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is Authorized) {
      try {
        int? currentPage = (currentState.favoritesList?.page ?? 1) + 1;

        ListResponse listResponse = await _api.getFavoriteMovies(
          currentState.sessionId,
          currentPage,
        );

        List<MovieModel>? currentList =
            currentState.favoritesList?.listMovieModel
              ?..addAll(listResponse.movies ?? []);

        emit(
          currentState.copyWith(
            sessionId: currentState.sessionId,
            favoritesList: FavoritesList(
              page: currentPage,
              listMovieModel: currentList ?? [],
              loading: false,
            ),
            account: currentState.account,
          ),
        );
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          emit(UnAuthorized());
        }
      }
    }
  }

  Future<void> _markAsFavorite(
    MarkAsFavoriteEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is Authorized) {
      try {
        await _api.markMovieAsFavorite(currentState.sessionId, event.request);

        add(GetFavoriteMoviesEvent());
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          emit(UnAuthorized());
        }
      }
    }
  }
}
