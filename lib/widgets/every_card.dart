import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learn_network_g10/models/all_product_model.dart';

Widget everyCard(Products pr){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Slidable(
      endActionPane: ActionPane(
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
          leading: Image.network(pr.images?[0] ?? "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"),
          title: Text(pr.title ?? "No title"),
          subtitle: Text("Price: ${pr.price}\$"),
          trailing: Text(pr.category ?? ""),
        ),
      ),
    ),
  );
}