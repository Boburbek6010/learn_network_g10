import 'package:flutter/cupertino.dart';

@immutable
final class AppColors{

  static const AppColors _service = AppColors._();

  const AppColors._();

  factory AppColors(){
    return _service;
  }

  static const Color primaryColor = Color(0xff52b2b5);
  static const Color backgroundColor = Color(0xff52b2b5);
  static const Color appBarColor = Color(0xff52b2b5);
  static const Color textColor = Color(0xffFB7B7B);
  static const Color notificationColor = Color(0xff53c321);

}