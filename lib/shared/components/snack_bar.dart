import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message, String? subMessage}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 20,
    content: subMessage != null ? Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          message,
        ),
        Text(
          subMessage
        ),
      ],
    ) : Text(
      message,
    ),
  ));
}
