import 'package:flutter/material.dart';

Widget textFieldWidget(TextEditingController textEditingController){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: TextField(
      onChanged: (text) async {
        // await searchProduct(text);
      },
      controller: textEditingController,
      decoration: const InputDecoration(
        labelText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
      ),
    ),
  );
}