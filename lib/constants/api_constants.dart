import 'package:flutter/cupertino.dart';

@immutable
sealed class ApiConstants{
  /// Properties
  static const duration = Duration(seconds: 10);
  static const baseUrl = "https://dummyjson.com";
  static const apiProducts = "/products";
  static const contentType = "application/json";
  static bool validate(int? statusCode) => statusCode! <= 205;
}