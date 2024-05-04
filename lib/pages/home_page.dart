import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learn_network_g10/constants/api_constants.dart';
import 'package:learn_network_g10/models/all_product_model.dart';
import 'package:learn_network_g10/services/dio_service.dart';
import 'package:learn_network_g10/services/network_service.dart';
import 'package:learn_network_g10/services/util_service.dart';
import 'package:learn_network_g10/widgets/every_card.dart';
import 'package:learn_network_g10/widgets/text_field_widget.dart';
import 'package:lottie/lottie.dart';

import '../widgets/error_widget.dart';
import '../widgets/main_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllProductModel? allProductModel;
  List<Products> list = [];
  bool isLoading = false;
  bool isError = false;
  TextEditingController textEditingController = TextEditingController();

  // Future<void> getAllProducts() async {
  //   isLoading = false;
  //   String? result =
  //       await NetworkService.getData(api: NetworkService.apiGetAllProduct, param: NetworkService.paramEmpty());
  //   if (result != null) {
  //     allProductModel = allProductModelFromJson(result);
  //     list = allProductModel!.products!;
  //     log(list.toString());
  //     isLoading = true;
  //     setState(() {});
  //   } else {
  //     isLoading = false;
  //     setState(() {});
  //   }
  // }
  //
  // Future<void> updateProduct(Products product) async {
  //   String? result = await NetworkService.updateData(
  //       api: NetworkService.apiGetAllProduct, param: NetworkService.paramEmpty(), data: product.toJson());
  // }
  //
  // Future<void> searchProduct(String text) async {
  //   isLoading = false;
  //   list = [];
  //   setState(() {});
  //   String? result = await NetworkService.getData(
  //       api: NetworkService.apiSearchProduct, param: NetworkService.paramSearchProduct(text));
  //   if (result != null) {
  //     allProductModel = allProductModelFromJson(result);
  //     list = allProductModel!.products!;
  //     isLoading = true;
  //     setState(() {});
  //   } else {
  //     isLoading = false;
  //     setState(() {});
  //   }
  // }

  /// DIO

  Future<void> getDioData() async {
    isLoading = false;
    var result = await DioService.getData(ApiConstants.apiProducts);
    log(result.runtimeType.toString());
    if (result.runtimeType == DioException) {
      isError = true;
      setState(() {});
      result = result as DioException;
      Utils.fireSnackBar(
          "DioException: Error at ${result.requestOptions.uri}. Because of ${result.type.name}", context);
    } else {
      allProductModel = allProductModelFromJson(result as String);
      list = allProductModel!.products!;
      log(list.toString());
      isLoading = true;
      setState(() {});
    }
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await getDioData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
        ),
        body: body(
          context: context,
          isError: isError,
          isLoading: isLoading,
          textEditingController: textEditingController,
          onPressed: () async {
            await getDioData();
          },
          list: list,
        ),
    );
  }
}
