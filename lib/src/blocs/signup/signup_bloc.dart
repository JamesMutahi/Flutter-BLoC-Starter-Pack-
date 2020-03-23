import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:staff_manager/src/blocs/signup/index.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

// dependency on authRepository and authBloc
  SignUpBloc({
    @required this.authRepository,
    @required this.authBloc,
  })  : assert(authBloc != null),
        assert(authRepository != null);

  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();

      try {
        final check = await authRepository.checkNet();
        if (check == true) {
          final authToken = await authRepository.signUp(
            event.email,
            event.username,
            event.password1,
            event.password2,
          );
          authBloc.add(LoggedIn(authToken: authToken));

          yield SignUpInitial();
        }
        else{
          throw ("No internet connection");
        }
      } catch (error) {
        yield SignUpFailure(error: error);
      }
    }
  }
}
