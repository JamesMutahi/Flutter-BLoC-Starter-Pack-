import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState {
  final dynamic error;

  const SignUpFailure({ @required this.error });

  @override
  String toString() => 'SignUpStateFailure { error: $error}';
}