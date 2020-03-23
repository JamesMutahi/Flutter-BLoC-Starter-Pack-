import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:staff_manager/src/blocs/login/index.dart';
import 'package:staff_manager/src/ui/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final AuthRepository authRepository;

  LoginPage({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using BlocProvider to access the AuthBloc from the LoginPage
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            authRepository: authRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
