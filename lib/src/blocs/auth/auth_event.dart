import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String authToken;

  const LoggedIn({@required this.authToken});

  @override
  List<Object> get props => [authToken];

  @override
  String toString() => 'LoggedIn {token: $authToken}';
}

class LoggedOut extends AuthEvent {}
