import 'package:flutter_app/data/account_model.dart';
import 'package:flutter_app/data/api_token.dart';
import 'package:flutter_app/data/avatar.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_app/data/favorite_response.dart';
import 'package:flutter_app/data/gravatar.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/session_id.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  AuthBloc()
      : super(AuthState(
            token: '',
            sessionId: '',
            page: 0,
            listMovieModel: [],
            // account: AccountModel(id: 0, name: '', avatar: Avatar(gravatar: Gravatar(hash: ''))),
            loading: true));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is GetTokenEvent) {
      yield* _getToken(event);
    }
    if (event is GetSessionIdEvent) {
      yield* _getSessionId(event);
    }
    if (event is GetFavoriteMoviesEvent) {
      yield* _getFavoriteMovies(event);
    }
    if (event is GetMoreFavoriteMoviesEvent) {
      yield* _getMoreFavoriteMovies(event);
    }
    if (event is MarkAsFavoriteEvent) {
      yield* _markAsFavorite(event);
    }
    // if (event is GetAccountEvent) {
    //   yield* _getAccount(event);
    // }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<AuthState> _getToken(AuthEvent movieEvent) async* {
    try {
      ApiToken token = await _api.getRequestToken();

      yield state.copyWith(token: token.token, loading: false);
    } catch (e) {
      yield state.copyWith(account: AccountModel(id: 0, name: '', avatar: Avatar(gravatar: Gravatar(hash: ''))), loading: false);
    }
  }

  Stream<AuthState> _getSessionId(AuthEvent movieEvent) async* {
    try {
      SessionId sessionId = await _api.getSessionId(state.token ?? '');

      yield state.copyWith(
          token: state.token, sessionId: sessionId.id, loading: false);
    } catch (e) {
      yield state.copyWith(account: AccountModel(id: 0, name: '', avatar: Avatar(gravatar: Gravatar(hash: ''))), loading: false);
    }
  }

  // Stream<AuthState> _getAccount(AuthEvent movieEvent) async* {
  //   try {
  //     AccountModel account = await _api.getAccount(state.sessionId ?? '');
  //
  //     yield state.copyWith(token: state.token, sessionId: state.sessionId, account: account, loading: false);
  //   } catch (e) {
  //     yield state.copyWith(loading: false);
  //   }
  // }

  Stream<AuthState> _getFavoriteMovies(AuthEvent movieEvent) async* {
    try {
      ListResponse listResponse =
          await _api.getFavoriteMovies(state.sessionId ?? '', 1);

      yield state.copyWith(
          token: state.token,
          sessionId: state.sessionId,
          page: 1,
          listMovieModel: listResponse.movies,
          // account: state.account,
          loading: false);
    } catch (e) {
      yield state.copyWith(account: AccountModel(id: 0, name: '', avatar: Avatar(gravatar: Gravatar(hash: ''))), loading: false);
    }
  }

  Stream<AuthState> _getMoreFavoriteMovies(AuthEvent movieEvent) async* {
    try {
      int? currentPage = (state.page ?? 1) + 1;

      ListResponse listResponse =
          await _api.getFavoriteMovies(state.sessionId ?? '', currentPage);

      List<MovieModel>? currentList = state.listMovieModel
        ?..addAll(listResponse.movies ?? []);

      yield state.copyWith(
          token: state.token,
          sessionId: state.sessionId,
          page: currentPage,
          listMovieModel: currentList,
          // account: state.account,
          loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }

  Stream<AuthState> _markAsFavorite(AuthEvent movieEvent) async* {
    try {
      FavoriteResponse response = await _api.markMovieAsFavorite(
          state.sessionId ?? '', movieEvent.request);

      print('response.statusCode ${response.statusCode}');
      print('response.statusMessage ${response.statusMessage}');

      yield state.copyWith(
          token: state.token, sessionId: state.sessionId, loading: false);
    } catch (e) {
      yield state.copyWith(loading: false);
    }
  }
}
