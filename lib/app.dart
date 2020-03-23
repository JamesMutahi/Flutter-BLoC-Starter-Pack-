import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_manager/src/ui/home/index.dart';
import 'package:staff_manager/src/ui/login/index.dart';
import 'package:staff_manager/src/ui/utils/splash_loader.dart';


class App extends StatelessWidget {
  final AuthRepository authRepository;

  App({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUninitialised) {
            return SplashLoader();
          }
          if (state is AuthAuthenticated) {
            return HomePage();
          }
          if (state is AuthUnauthenticated) {
            return LoginPage(authRepository: authRepository);
          }
          if (state is AuthLoading) {
            return SplashLoader();
          }
        },
      ),
    );
  }
}
