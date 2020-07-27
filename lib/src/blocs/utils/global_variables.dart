import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure;
import 'package:dio/dio.dart';

final secureStorage = secure.FlutterSecureStorage();

BaseOptions options = new BaseOptions(
  baseUrl: "https://api.api.com",
  connectTimeout: 10000,
  receiveTimeout: 6000,
);

var dio = Dio(options);