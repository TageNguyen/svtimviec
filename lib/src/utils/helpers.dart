// this file contains common methods used in whole app

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

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
              const SizedBox(width: 4.0),
              Container(
                margin: const EdgeInsets.all(4.0),
                child: Text(message ?? AppStrings.loading),
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

/// show bottom picker
Future<T?> showCupertinoBottomPicker<T>(
  BuildContext context, {
  T? initialItem,
  required List<T> listData,
  required Widget Function(T value) item,
}) async {
  T? result = initialItem ?? listData[0];
  return showModalBottomSheet<T>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, result);
                  },
                  child: const Text(AppStrings.confirm),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: initialItem != null
                          ? listData.indexOf(initialItem)
                          : 0),
                  backgroundColor: Colors.white,
                  itemExtent: 24.0,
                  onSelectedItemChanged: (index) => result = listData[index],
                  children: listData.map<Widget>((e) => item(e)).toList(),
                ),
              ),
            ],
          ),
        );
      }).then((value) => value);
}

void showToastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: AppColors.black.withOpacity(0.8),
    textColor: Colors.white,
  );
}
