import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learn_network_g10/models/all_product_model.dart';


typedef Edit = void Function(BuildContext context, Products product);
typedef Delete = void Function(BuildContext context, Products product);

Widget everyCard({required Products product, required Edit edit, required Delete delete}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_){
              edit(_, product);
            },
            autoClose: true,
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(20),
          ),
          SlidableAction(
            onPressed: (_){
              delete(_, product);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            autoClose: true,
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
          leading: product.images != null ?Image.network(product.images!.isNotEmpty ?product.images!.first : "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"):Image.network("https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"),
          title: Text(product.title ?? "No title"),
          subtitle: Text("Price: ${product.price}\$"),
          trailing: Text(product.category ?? ""),
        ),
      ),
    ),
  );
}