// this file contains common methods used in whole app

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showLoading<T extends Object?>(BuildContext context,
    {String? message}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 100.0,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Container(
                margin: const EdgeInsets.all(4.0),
                child: Text(message ?? 'Loading'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<T?> showNotificationDialog<T extends Object?>(
    BuildContext context, String message,
    {String? title}) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<bool> showConfirmDialog(
  BuildContext context, {
  String? title,
  String? message,
  String actionText = 'Đồng ý',
}) {
  if (Platform.isIOS) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text('$message'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(actionText),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: Text('$message'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Huỷ'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(actionText),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
