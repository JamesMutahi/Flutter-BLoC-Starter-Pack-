import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  // has dependency on UserRepository class
  AuthBloc({@required this.authRepository}): assert (authRepository != null);

  @override
  // initialise state to AuthUninitialised
  AuthState get initialState => AuthUninitialised();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepository.hasToken();

      if (hasToken) {
        yield AuthAuthenticated();
      }
      else {
        yield AuthUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthLoading();
      await authRepository.persistToken(event.authToken);
      yield AuthAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthLoading();
      await authRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}