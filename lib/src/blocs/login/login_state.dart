import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final dynamic error;

  const LoginFailure({ @required this.error });

  @override
  String toString() => 'LoginFailure { error: $error}';
}