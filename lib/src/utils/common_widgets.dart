// this file contains common widgets

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

const loadingWidget = Center(
  child: CircularProgressIndicator(),
);

const emptyMessage = Center(
  child: Text(
    AppStrings.emptyList,
    style: AppTextStyles.defaultRegular,
  ),
);

Widget errorScreen({String? message}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(message ?? AppStrings.anErrorHasOccurred),
    ),
  );
}

Widget buildNetworkCircleAvatar(String url, {double size = 32.0}) {
  return Container(
    height: size,
    width: size,
    padding: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.tintLighter, width: 0.5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>
            Image.asset(ImagePaths.avatarPlaceholder),
        errorWidget: (context, url, error) =>
            Image.asset(ImagePaths.avatarPlaceholder, fit: BoxFit.contain),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget buildFileCircleAvatar(File? file, {double size = 32.0}) {
  return Container(
    height: size,
    width: size,
    padding: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.tintLighter, width: 1),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: FadeInImage(
        image: FileImage(file ?? File('')),
        placeholder: const AssetImage(ImagePaths.avatarPlaceholder),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(ImagePaths.avatarPlaceholder, fit: BoxFit.contain);
        },
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget buildNetworkImage(String url, {bool coverPlaceholder = false}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Image.asset(
        ImagePaths.companyPlaceholderImage,
        fit: coverPlaceholder ? BoxFit.cover : BoxFit.contain),
    errorWidget: (context, url, error) => Image.asset(
        ImagePaths.companyPlaceholderImage,
        fit: coverPlaceholder ? BoxFit.cover : BoxFit.contain),
    fit: BoxFit.cover,
  );
}

Widget buildFileImage(File? file, {bool coverPlaceholder = false}) {
  return FadeInImage(
    image: FileImage(file ?? File('')),
    placeholder: const AssetImage(ImagePaths.companyPlaceholderImage),
    imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset(ImagePaths.companyPlaceholderImage,
          fit: coverPlaceholder ? BoxFit.cover : BoxFit.contain);
    },
    fit: BoxFit.cover,
  );
}
