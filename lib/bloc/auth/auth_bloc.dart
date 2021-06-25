import 'package:flutter_app/data/api_token.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_app/data/favorite_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/session_id.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Api _api = Api();

  AuthBloc() : super(UnAuthorized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is GetTokenEvent) {
      yield* _getToken();
    }
    if (event is GetSessionIdEvent) {
      yield* _getSessionId();
    }
    if (event is GetFavoriteMoviesEvent) {
      yield* _getFavoriteMovies();
    }
    if (event is GetMoreFavoriteMoviesEvent) {
      yield* _getMoreFavoriteMovies();
    }
    if (event is MarkAsFavoriteEvent) {
      yield* _markAsFavorite(event);
    }
  }

  Stream<AuthState> _getToken() async* {
    try {
      ApiToken token = await _api.getRequestToken();

      yield AuthRequestToken(token.token);
    } catch (e) {
      yield UnAuthorized();
    }
  }

  Stream<AuthState> _getSessionId() async* {
    final currentState = state;
    if (currentState is AuthRequestToken) {
      try {
        SessionId response = await _api.getSessionId(currentState.token);

        final sessionId = response.id;

        if (sessionId == null) {
          yield UnAuthorized();
        } else {
          yield Authorized(sessionId);
          // yield* _getAccount();
          yield* _getFavoriteMovies();
        }
      } catch (e) {
        yield UnAuthorized();
      }
    } else {
      yield UnAuthorized();
    }
  }

  // Stream<AuthState> _getAccount() async* {
  //   final currentState = state;
  //   if (currentState is Authorized) {
  //     try {
  //       AccountModel account =
  //       await _api.getAccount(currentState.sessionId);
  //
  //       yield currentState.copyWith(
  //           sessionId: currentState.sessionId,
  //           favoritesList: FavoritesList(
  //               page: currentState.favoritesList?.page,
  //               listMovieModel: currentState.favoritesList?.listMovieModel,
  //               loading: false),
  //         account: account
  //           );
  //     } catch (e) {}
  //   }
  // }

  Stream<AuthState> _getFavoriteMovies() async* {
    final currentState = state;
    if (currentState is Authorized) {
      try {
        ListResponse listResponse =
            await _api.getFavoriteMovies(currentState.sessionId, 1);

        yield currentState.copyWith(
            sessionId: currentState.sessionId,
            favoritesList: FavoritesList(
                page: 1,
                listMovieModel: listResponse.movies ?? [],
                loading: false));
      } catch (e) {}
    }
  }

  Stream<AuthState> _getMoreFavoriteMovies() async* {
    final currentState = state;
    if (currentState is Authorized) {
      try {
        int? currentPage = (currentState.favoritesList?.page ?? 1) + 1;

        ListResponse listResponse =
            await _api.getFavoriteMovies(currentState.sessionId, currentPage);

        List<MovieModel>? currentList = currentState
            .favoritesList?.listMovieModel
          ?..addAll(listResponse.movies ?? []);

        yield currentState.copyWith(
            favoritesList: FavoritesList(
                page: currentPage,
                listMovieModel: currentList ?? [],
                loading: false));
      } catch (e) {}
    }
  }

  Stream<AuthState> _markAsFavorite(MarkAsFavoriteEvent event) async* {
    final currentState = state;
    if (currentState is Authorized) {
      try {
        FavoriteResponse response = await _api.markMovieAsFavorite(
            currentState.sessionId, event.request);

        print('response.statusCode ${response.statusCode}');
        print('response.statusMessage ${response.statusMessage}');

        yield* _getFavoriteMovies();
      } catch (e) {}
    }
  }
}
