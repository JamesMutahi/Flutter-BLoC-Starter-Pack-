import 'dart:io';

import 'package:staff_manager/src/blocs/utils/global_variables.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';


class AuthProvider {
  Future<bool> checkInternetAccess() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    }
    return false;
  }

  Future<dynamic> signUp(
      {@required String email,
      @required String username,
      @required String password1,
      @required String password2}) async {
    // Get token
    try {
      Response response = await dio.post(
        '/rest-auth/registration/',
        data: {
          "email": email,
          "username": username,
          "password1": password1,
          "password2": password2
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      if (response.statusCode == 200) {
        return response.data['key'];
      } else if (response.statusCode == 401) {
        throw (response.data);
      }
    } on DioError catch (e) {
      String message = "Error connecting to API: $e";
      throw message;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> authenticate({
    @required String email,
    @required String password,
  }) async {
    // Get token
    try {
      Response response = await dio.post(
        '/rest-auth/login/',
        data: {"email": email, "password": password},
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      if (response.statusCode == 200) {
        return response.data['key'];
      } else if (response.statusCode == 401) {
        throw (response.data);
      }
    } on DioError catch (e) {
      String message = "Error connecting to API: $e";
      return message;
    } catch (e) {
      throw e;
    }

    throw ("Check Internet connection. Cannot connect.");
  }

  Future<void> deleteToken() async {
    // delete token from key store
    await secureStorage.delete(key: "token");
  }

  Future<void> persistToken(String authToken) async {
    // write to keystore/keychain
    await secureStorage.write(key: "token", value: authToken);
    String message = "token saved";
    return message;
  }

  Future<bool> hasToken() async {
    // read from keystore/keychain
    String value = await secureStorage.read(key: "token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }
}
