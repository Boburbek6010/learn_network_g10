import 'package:flutter/cupertino.dart';

@immutable
sealed class ApiConstants{
  /// Properties
  static bool isTester = true;
  static const duration = Duration(seconds: 30);
  static const apiProducts = "/product";
  static const contentType = "application/json";
  static bool validate(int? statusCode) => statusCode! <= 205;
  static const SERVER_DEVELOPMENT = "https://6554a27063cafc694fe6bbeb.mockapi.io";
  static const SERVER_DEPLOYMENT = "https://6554a27063cafc694fe6bbeb.mockapi.io";
  static String getServer(){
    if(isTester) return SERVER_DEVELOPMENT;
    return SERVER_DEPLOYMENT;
  }
}