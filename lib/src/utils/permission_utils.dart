import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_job_applying/src/utils/helpers.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class PermissionUtil {
  static Future<bool> checkPhotoAccessPermission(BuildContext context,
      {bool showDialog = true}) async {
    var photosStatus = await Permission.photos.status;
    if (photosStatus != PermissionStatus.granted) {
      var request = await Permission.photos.request();
      if (request == PermissionStatus.denied ||
          request == PermissionStatus.permanentlyDenied) {
        if (showDialog) {
          showConfirmDialog(
            context,
            title: AppStrings.notification,
            actionText: AppStrings.textContinue,
            message: AppStrings.youNeedToGrantPhotosAccessToUseThisFeature,
          ).then((confirm) {
            if (confirm) {
              AppSettings.openInternalStorageSettings();
            }
          });
        }
      }
      return request == PermissionStatus.granted;
    }
    return true;
  }
}
