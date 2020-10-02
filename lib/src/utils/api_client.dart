import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  ApiClient() {
    initClient();
  }

  final String baseUrl = 'https://www.mocky.io/v2';

  Dio _dio;

  //  Options _options;
  BaseOptions _baseOptions;

  initClient() async {
    _baseOptions = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 1000000,
        followRedirects: true,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true);

    _dio = new Dio(_baseOptions);
  }

  Dio get dio => _dio;

  ///=====================================================
  ///
  /// ====================================================

  //Login
  Future<Response> storeApi() {
    return _dio.get("/5dfccffc310000efc8d2c1ad");
  }
}
