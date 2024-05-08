import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


@immutable
class NetworkService{

  static const NetworkService _service = NetworkService._internal();

  const NetworkService._internal();

  factory NetworkService(){
    return _service;
  }

  /// base url
  static const String _baseUrl = "dummyjson.com";

  /// api
  static const String apiGetAllProduct = "/products";
  static const String apiSearchProduct = "/products/search";

  /// headers
  static const Map<String, String> headers = {
   "Content-Type":"application/json"
  };


  /// methods

  // get
  static Future<String?>getData({required String api, required Map<String, Object?>param})async{
    Uri url = Uri.https(_baseUrl, api, param);
    Response response = await get(url, headers: headers);
    if(response.statusCode <= 201){
      return response.body;
    }else{
      return null;
    }
  }


  // post
  static Future<String?>postData({required String api, required Map<String, Object?>param, required Map<String, Object?> data})async{
    Uri url = Uri.https(_baseUrl, api, param);
    Response response = await post(url, body: jsonEncode(data),headers: headers);
    if(response.statusCode <= 201){
      return response.body;
    }else{
      return null;
    }
  }


  // update
  static Future<String?>updateData({required String api, required Map<String, Object?>param, required Map<String, Object?> data})async{
    Uri url = Uri.https(_baseUrl, api, param);
    Response response = await put(url, body: jsonEncode(data),headers: headers);
    if(response.statusCode <= 201){
      return response.body;
    }else{
      return null;
    }
  }


  // delete
  static Future<String?>deleteData({required String api, required Map<String, Object?>param, required Map<String, Object?> data})async{
    Uri url = Uri.https(_baseUrl, api, param);
    Response response = await delete(url, body: jsonEncode(data),headers: headers);
    if(response.statusCode <= 201){
      return response.body;
    }else{
      return null;
    }
  }

  /// params
  static Map<String, Object?>paramEmpty() => const <String, Object?>{};

  static Map<String, Object?>paramSearchProduct(String text) => <String, Object?>{
    "q":text,
  };

}