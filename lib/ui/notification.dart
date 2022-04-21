import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';

Future<void> showSuccessNotification(
  BuildContext context, {
  String? title,
  required String message,
}) async {
  Flushbar(
    titleText: title != null
        ? Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          )
        : null,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    margin: const EdgeInsets.all(8.0),
    borderRadius: const BorderRadius.all(
      Radius.circular(8),
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
    maxWidth: MediaQuery.of(context).size.width,
  ).show(context);
}

Future<void> showErrorNotification(
  BuildContext context, {
  String? title,
  required String message,
}) async {
  Flushbar(
    titleText: title != null
        ? Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          )
        : null,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    margin: const EdgeInsets.all(8.0),
    borderRadius: const BorderRadius.all(
      Radius.circular(8),
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
    maxWidth: MediaQuery.of(context).size.width,
  ).show(context);
}