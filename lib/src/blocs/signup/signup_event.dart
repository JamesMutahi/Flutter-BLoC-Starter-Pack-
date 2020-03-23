import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String username;
  final String password1;
  final String password2;

  const SignUpButtonPressed({
    @required this.email,
    @required this.username,
    @required this.password1,
    @required this.password2,
  });

  @override
  List<Object> get props => [email, username, password1, password2];

  @override
  String toString() =>
      'SignUpButtonPressed { email: $email, username: $username, password1: $password1, password2: $password2 }';
}
