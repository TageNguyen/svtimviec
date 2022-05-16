import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/change_password/change_password_bloc.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  late ChangePasswordBloC bloC;

  @override
  void initState() {
    bloC = context.read<ChangePasswordBloC>();
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
        child: Column(
          children: [
            _buildOldPasswordInputField(context),
            const SizedBox(height: 12.0),
            _buildNewPasswordInputField(context),
            const SizedBox(height: 12.0),
            _buildConfirmNewPasswordInputField(context),
            const SizedBox(height: 36.0),
            _buildChangePasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOldPasswordInputField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.eyeButtonStatusStream,
      builder: (_, snapshot) {
        bool hidePassword = snapshot.data ?? true;
        return InputTextField(
          controller: _oldPasswordController,
          hintText: AppStrings.oldPassword,
          keyboardType: TextInputType.visiblePassword,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: bloC.changeEyeButtonStatus,
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkBlue),
          ),
          onChanged: (password) {
            bloC.requestModel.oldPassword = password.trim();
            bloC.updateChangePasswordButtonState();
          },
        );
      },
    );
  }

  Widget _buildNewPasswordInputField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.eyeButtonStatusStream,
      builder: (_, snapshot) {
        bool hidePassword = snapshot.data ?? true;
        return InputTextField(
          controller: _newPasswordController,
          hintText: AppStrings.newPassword,
          keyboardType: TextInputType.visiblePassword,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: bloC.changeEyeButtonStatus,
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkBlue),
          ),
          onChanged: (password) {
            bloC.requestModel.newPassword = password.trim();
            bloC.updateChangePasswordButtonState();
          },
        );
      },
    );
  }

  Widget _buildConfirmNewPasswordInputField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.eyeButtonStatusStream,
      builder: (_, snapshot) {
        bool hidePassword = snapshot.data ?? true;
        return InputTextField(
          controller: _confirmNewPasswordController,
          hintText: AppStrings.confirmNewPassword,
          keyboardType: TextInputType.visiblePassword,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: bloC.changeEyeButtonStatus,
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkBlue),
          ),
          onChanged: (password) {
            bloC.requestModel.confirmNewPassword = password.trim();
            bloC.updateChangePasswordButtonState();
          },
        );
      },
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.changePasswordButtonState,
      builder: (_, snapshot) {
        bool isEnable = snapshot.data ?? false;
        return ElevatedButton(
          onPressed: isEnable ? changePassword : null,
          child: const Text(AppStrings.changePassword),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.changePassword),
      centerTitle: true,
    );
  }

  void changePassword() {
    showLoading(context);
    bloC.updatePassword().then((_) {
      Navigator.pop(context); // hide loading
      showNotificationDialog(context,
              AppStrings.changePasswordSuccessfullyPleaseLoginAgainToUseApp)
          .then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteNames.root, (Route<dynamic> route) => false);
        context.read<UserManager>().clear();
      });
    }).catchError((error) {
      Navigator.pop(context); // hide loading
      showNotificationDialog(context, error.message);
    });
  }
}
