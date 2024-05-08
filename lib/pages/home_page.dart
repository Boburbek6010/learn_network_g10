import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learn_network_g10/constants/api_constants.dart';
import 'package:learn_network_g10/models/all_product_model.dart';
import 'package:learn_network_g10/services/dio_service.dart';
import 'package:learn_network_g10/services/util_service.dart';
import 'package:learn_network_g10/style/colors.dart';
import '../widgets/every_card.dart';
import '../widgets/main_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Products> products = [];
  bool isLoading = false;
  bool isError = false;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController categoryController = TextEditingController();


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


  Future<void>refresh(String? result, [String msg = "Successfully done"])async{
    if(result != null){
      Utils.fireSnackBar(msg, context);
    }
    await read();
    setState(() {});
  }

  /// DIO Service

  // READ
  Future<void> read() async {
    isLoading = false;
    String? result = await DioService.getData(context, ApiConstants.apiProducts);
    if(result != null){
      products = listProductsFromJson(result);
      isLoading = true;
      setState(() {});
    }else{
      isLoading = true;
      setState(() {});
    }
  }

  // CREATE
  Future<void>create()async{
    String title = titleController.text.trim().toString();
    String price = costController.text.trim().toString();
    String category = categoryController.text.trim().toString();
    Products products = Products(
      title: title,
      category: category,
      price: int.parse(price),
      description: "nothing",
      discountPercentage: 1,
      rating: 1,
      stock: 1,
      brand: "brand",
      thumbnail: "thumbnail",
      images: []
    );
    isLoading = false;
    String? result = await DioService.postData(context, ApiConstants.apiProducts, products.toJson());
    await refresh(result, "Successfully created");
  }

  // UPDATE
  Future<void>update(Products product)async{
    String? result = await DioService.updateData(context, ApiConstants.apiProducts, product.id!, product.toJson());
    await refresh(result, "Successfully updated");
  }

  // DELETE
  Future<void>delete(Products product)async{
    String? result = await DioService.deleteData(context, ApiConstants.apiProducts, product.id!, product.toJson());
    await refresh(result, "Deleted");
  }

  void clear(){
    titleController.clear();
    costController.clear();
    categoryController.clear();
  }

  // request
  Future<void> request() async {
    isLoading = false;
    String? result = await DioService.request(context, ApiConstants.apiProducts, RequestMethod.GET);
    if(result != null){
      products = listProductsFromJson(result);
      isLoading = true;
      setState(() {});
    }else{
      isLoading = true;
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
    isLoading = false;
    request().then((value) {
      isLoading = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
        ),
        body: body(
          context: context,
          isError: isError,
          isLoading: isLoading,
          textEditingController: textEditingController,
          onPressed: () async {
            // await read();
          },
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) {
              Products product = products[index];
              return everyCard(
                product: product,
                edit: (context, product){
                  titleController.text = product.title!;
                  costController.text = product.price!.toString();
                  categoryController.text = product.category!;
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                hintText: "TITLE",
                                hintStyle: TextStyle(
                                  color: AppColors.textColor,
                                )
                              ),
                            ),
                            TextField(
                              controller: costController,
                              decoration: const InputDecoration(
                                hintText: "COST",
                              ),
                            ),
                            TextField(
                              controller: categoryController,
                              decoration: const InputDecoration(
                                hintText: "CATEGORY",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: ()async{
                              product.title = titleController.text;
                              product.price = int.parse(costController.text);
                              product.category = categoryController.text;
                              log(product.title.toString());
                              log(product.price.toString());
                              log(product.category.toString());
                              await update(product);
                              Navigator.pop(context);
                            },
                            child: const Text("Create"),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                  clear();
                },
                delete: (context, product)async{
                  await DioService.request(
                    context,
                    ApiConstants.apiProducts,
                    RequestMethod.DELETE,
                    {}, // param
                    {}, // data
                    product.id,
                  );
                  await refresh("deleted");
                },
              );
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "TITLE",
                        ),
                      ),
                      TextField(
                        controller: costController,
                        decoration: const InputDecoration(
                          hintText: "COST",
                        ),
                      ),
                      TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          hintText: "CATEGORY",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: ()async{
                        await create();
                        Navigator.pop(context);
                      },
                      child: const Text("Create"),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
          );
          clear();
        },
        child: const Text("+"),
      ),
    );
  }
}