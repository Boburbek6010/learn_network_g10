import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget errorWidget(BuildContext context, void Function()? onPressed) {
  return Column(
    children: [
      const SizedBox(height: 100),
      SizedBox(
        height: 300,
        width: double.infinity,
        child: Lottie.asset("assets/lotties/error.json"),
      ),
      const Spacer(),
      MaterialButton(
        color: Colors.red,
        shape: const StadiumBorder(),
        minWidth: 250,
        height: 55,
        onPressed: onPressed,
        child: const Text("Retry"),
      ),
      const SizedBox(height: 100),
    ],
  );
}