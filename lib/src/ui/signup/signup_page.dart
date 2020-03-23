import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:staff_manager/src/blocs/signup/index.dart';
import 'package:staff_manager/src/ui/signup/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  final AuthRepository authRepository;

  SignUpPage({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using BlocProvider to access the AuthBloc from the LoginPage
      body: BlocProvider(
        create: (context) {
          return SignUpBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            authRepository: authRepository,
          );
        },
        child: SignUpForm(),
      ),
    );
  }
}
