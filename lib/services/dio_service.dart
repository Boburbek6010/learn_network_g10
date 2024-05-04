import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../constants/api_constants.dart';

enum ApiResult{
  success,
  error,
}


@immutable
sealed class DioService{

  /// Options
  static BaseOptions _options = BaseOptions();

  static Dio _dio = Dio();

  static Dio init(){
    _options = BaseOptions(
      connectTimeout: ApiConstants.duration,
      receiveTimeout: ApiConstants.duration,
      sendTimeout: ApiConstants.duration,
      baseUrl: ApiConstants.baseUrl,
      contentType: ApiConstants.contentType,
      validateStatus: ApiConstants.validate,
    );
    _dio = Dio(_options);
    return _dio;
  }

  /// method
  static Future<Object>getData(String api, [Map<String, dynamic>? param])async{
    try{
      Response response = await init().get(api, queryParameters: param);
      return jsonEncode(response.data);
    } on DioException catch(e){
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
      return e;
    }
  }



}