import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learn_network_g10/models/AllProductModel.dart';
import 'package:learn_network_g10/services/network_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllProductModel? allProductModel;
  List<Products> list = [];
  bool isLoading = false;
  TextEditingController textEditingController = TextEditingController();

  Future<void> getAllProducts() async {
    isLoading = false;
    String? result =
        await NetworkService.getData(api: NetworkService.apiGetAllProduct, param: NetworkService.paramEmpty());
    if (result != null) {
      allProductModel = allProductModelFromJson(result);
      list = allProductModel!.products!;
      log(list.toString());
      isLoading = true;
      setState(() {});
    } else {
      isLoading = false;
      setState(() {});
    }
  }

  Future<void> updateProduct(Products product) async {
    String? result = await NetworkService.updateData(
        api: NetworkService.apiGetAllProduct, param: NetworkService.paramEmpty(), data: product.toJson());
  }

  Future<void> searchProduct(String text) async {
    isLoading = false;
    list = [];
    setState(() {});
    String? result = await NetworkService.getData(
        api: NetworkService.apiSearchProduct, param: NetworkService.paramSearchProduct(text));
    if (result != null) {
      allProductModel = allProductModelFromJson(result);
      list = allProductModel!.products!;
      isLoading = true;
      setState(() {});
    } else {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: TextField(
                onChanged: (text) async {
                  await searchProduct(text);
                  setState(() {});
                },
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        var pr = list[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Slidable(
                            endActionPane: ActionPane(
                              // dragDismissible: true,
                              // dismissible: Container(
                              //   color: Colors.red,
                              //   child: Text("Configure"),
                              // ),
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  autoClose: false,
                                  backgroundColor: const Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  autoClose: false,
                                  label: 'Delete',
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ],
                            ),
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: Colors.blueGrey.withOpacity(0.3),
                              elevation: 0,
                              child: ListTile(
                                leading: Image.network(pr.images?[0] ??
                                    "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"),
                                title: Text(pr.title ?? "No title"),
                                subtitle: Text("Price: ${pr.price}\$"),
                                trailing: Text(pr.category ?? ""),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ));
  }
}
