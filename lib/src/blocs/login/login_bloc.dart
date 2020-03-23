import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:staff_manager/src/blocs/login/index.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

// dependency on authRepository and authBloc
  LoginBloc({
    @required this.authRepository,
    @required this.authBloc,
  })  : assert(authBloc != null),
        assert(authRepository != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final check = await authRepository.checkNet();
        if (check == true) {
          final authToken = await authRepository.authenticate(
            event.email,
            event.password,
          );
          authBloc.add(LoggedIn(authToken: authToken));

          yield LoginInitial();
        }
        else{
          throw ("No internet connection");
        }
      } catch (error) {
        yield LoginFailure(error: error);
      }
    }
  }
}
