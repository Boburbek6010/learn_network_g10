import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learn_network_g10/widgets/text_field_widget.dart';

import '../models/all_product_model.dart';
import 'error_widget.dart';
import 'every_card.dart';

Widget body({
  required BuildContext context,
  required bool isError,
  required bool isLoading,
  required TextEditingController textEditingController,
  required void Function()? onPressed,
  required Widget child,
}) {
  return isError
      ? errorWidget(
          context,
          onPressed,
        )
      : Column(
          children: [
            textFieldWidget(textEditingController),
            Expanded(
              child: isLoading
                  ? child
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        );
}
