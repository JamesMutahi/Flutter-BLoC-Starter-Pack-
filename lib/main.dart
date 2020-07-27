import 'package:staff_manager/src/blocs/auth/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_manager/app.dart';
import 'package:staff_manager/src/blocs/utils/index.dart';

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authRepository = AuthRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(authRepository: authRepository)..add(AppStarted()),
        ),
      ],
      child: App(authRepository: authRepository),
    ),
  );
}
