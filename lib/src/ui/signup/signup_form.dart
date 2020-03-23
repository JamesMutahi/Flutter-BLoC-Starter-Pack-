import 'package:staff_manager/src/blocs/signup/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _password1Controller = TextEditingController();

  final _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() async {
      BlocProvider.of<SignUpBloc>(context).add(
        SignUpButtonPressed(
          email: _emailController.text,
          username: _usernameController.text,
          password1: _password1Controller.text,
          password2: _password2Controller.text,
        ),
      );
    }

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  controller: _emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _password1Controller,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'confirm password'),
                  controller: _password2Controller,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed:
                      state is! SignUpLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                ),
                Container(
                  child: state is SignUpLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
