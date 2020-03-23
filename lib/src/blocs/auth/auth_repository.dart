import 'dart:async';

import 'package:staff_manager/src/blocs/auth/auth_provider.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();

  Future<bool> hasToken() async {
    final check = await _authProvider.hasToken();
    return check;
  }

  Future<void> persistToken(authToken) async {
    await _authProvider.persistToken(authToken);
  }

  Future<void> deleteToken() async {
    await _authProvider.deleteToken();
  }

  Future<String> signUp(
      String email, String username, String password1, String password2) async {
    final authToken = await _authProvider.signUp(
        email: email,
        username: username,
        password1: password1,
        password2: password2);
    return authToken;
  }

  Future<String> authenticate(String email, String password) async {
    final authToken =
        await _authProvider.authenticate(email: email, password: password);
    return authToken;
  }

  Future<bool> checkNet() async {
    final check = await _authProvider.checkInternetAccess();
    return check;
  }
}
