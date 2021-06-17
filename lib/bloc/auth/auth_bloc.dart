import 'package:flutter_app/data/api_token.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/session_id.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Api _api = Api();

  //REVIEW remove all fields with state from Bloc. They must be placed in state

  AuthBloc() : super(AuthState(token: ApiToken(token: ''), sessionId: '', loading: true));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is GetTokenEvent) {
      yield* _getToken(event);
    }
    if (event is GetSessionIdEvent) {
      yield* _getSessionId(event);
    }
  }

  //REVIEW I don't see any yeilds. This function is Future by nature too
  Stream<AuthState> _getToken(AuthEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: true);

      ApiToken token = await _api.getRequestToken();

      yield state.copyWith(
        token: token,
          loading: false);
    } catch (e) {
      yield state.copyWith(token: ApiToken(token: ''), loading: false);
    }
  }

  Stream<AuthState> _getSessionId(AuthEvent movieEvent) async* {
    try {
      yield state.copyWith(loading: false);

      SessionId sessionId = await _api.getSessionId(state.token);

      String? id = sessionId.id;

      yield state.copyWith(
          sessionId: id,
          loading: false);
    } catch (e) {
      yield state.copyWith(token: ApiToken(token: ''), loading: false);
    }
  }

}
