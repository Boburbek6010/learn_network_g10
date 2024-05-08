

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
@immutable
final class ClientService{

  static const ClientService _service = ClientService._internal();

  const ClientService._internal();

  factory ClientService(){
    return _service;
  }

  static const String _baseUrl = "https://jsonplaceholder.typicode.com";

  static Future<String?> get({required String api}) async {

    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    // url yasab olinayabdi
    Uri url = Uri.parse('$_baseUrl/$api');

    // get methodi orqali so'rov jo'natilayabdi
    HttpClientRequest request = await httpClient.getUrl(url);

    // jo'natilgan so'rov close qilib yopilayabdi
    HttpClientResponse response = await request.close();

    // tekshirilayabdi agar ok bo'lsa response body qaytarilayabdi
    if (response.statusCode == HttpStatus.ok) {

      String responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      return responseBody;

      // throw exception
    } else {
      httpClient.close();
      throw Exception('Failed to load data');
    }

  }

  static Future<String?> post({required String api, required Map<String, Object?> data}) async {

    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    // url yasab olinayabdi
    Uri url = Uri.parse('$_baseUrl/$api');

    // get methodi orqali so'rov jo'natilayabdi
    HttpClientRequest request = await httpClient.postUrl(url);

    // headers qo'shilayabdi
    request.headers.set('Content-Type', 'application/json');

    //  Map data avval string formatga keyin esa utf8 characterga o'tib requestga qo'shilayabdi
    request.add(utf8.encode(jsonEncode(data)));

    // jo'natilgan so'rov close qilib yopilayabdi
    HttpClientResponse response = await request.close();

    // tekshirilayabdi agar ok bo'lsa response body qaytarilayabdi
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {

      String responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      return responseBody;

      // throw exception
    } else {
      httpClient.close();
      throw Exception('Failed to load data');
    }

  }

  static Future<String?> put({required String api, required Map<String, Object?> data}) async {

    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    // url yasab olinayabdi
    Uri url = Uri.parse('$_baseUrl/$api');

    // get methodi orqali so'rov jo'natilayabdi
    HttpClientRequest request = await httpClient.putUrl(url);

    // headers qo'shilayabdi
    request.headers.set('Content-Type', 'application/json');

    //  Map data avval string formatga keyin esa utf8 characterga o'tib requestga qo'shilayabdi
    request.add(utf8.encode(jsonEncode(data)));

    // jo'natilgan so'rov close qilib yopilayabdi
    HttpClientResponse response = await request.close();

    // tekshirilayabdi agar ok bo'lsa response body qaytarilayabdi
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {

      String responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      return responseBody;

      // throw exception
    } else {
      httpClient.close();
      throw Exception('Failed to load data');
    }

  }

  Future<String?> delete({required String api}) async {

    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    try {

      // url yasab olinayabdi
      Uri url = Uri.parse('$_baseUrl/$api');

      // delete methodi orqali so'rov jo'natilayabdi
      HttpClientRequest request = await httpClient.deleteUrl(url);


      // jo'natilgan so'rov close qilib yopilayabdi
      HttpClientResponse response = await request.close();


      String responseBody = await response.transform(utf8.decoder).join();


      if (response.statusCode == HttpStatus.noContent || response.statusCode == HttpStatus.ok) {
        return responseBody;

      } else {
        throw Exception('Failed to delete resource: ${response.statusCode}, $responseBody');
      }
    } finally {
      httpClient.close();
    }
  }






}