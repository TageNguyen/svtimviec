import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/auth/register/register_bloc.dart';
import 'package:student_job_applying/src/modules/auth/widgets/type_role_checkbox.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordlNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  late RegisterBloC bloC;

  @override
  void initState() {
    bloC = context.read<RegisterBloC>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailNode.dispose();
    _passwordlNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.registerAccount),
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            _backgroundImage(context),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: _buildAppLogo(context),
                  ),
                  SizedBox(height: screenSize.height / 8),
                  _registerTitle(context),
                  const SizedBox(height: 28.0),
                  _buildNameInputField(context),
                  const SizedBox(height: 12.0),
                  _buildEmailInputField(context),
                  const SizedBox(height: 12.0),
                  _buildPasswordInputField(context),
                  const SizedBox(height: 12.0),
                  _buildConfirmPasswordInputField(context),
                  const SizedBox(height: 5.0),
                  TypeRoleCheckBox(
                      title: AppStrings.recruiter,
                      onChanged: (type) {
                        bloC.requestModel.typeRole = type;
                      }),
                  const SizedBox(height: 24.0),
                  Align(
                      alignment: Alignment.centerRight,
                      child: _buildRegisterButton(context)),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.registerButtonStatusStream,
      builder: (_, snapshot) {
        bool isEnable = snapshot.data ?? false;
        return ElevatedButton(
          onPressed: isEnable
              ? () {
                  _register(context).catchError((error) {
                    Navigator.pop(context); // hide loading
                    showNotificationDialog(context, error.message);
                  });
                }
              : null,
          child: const Text(AppStrings.register),
        );
      },
    );
  }

  Widget _buildConfirmPasswordInputField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.eyeButtonStatusStream,
      builder: (_, snapshot) {
        bool hidePassword = snapshot.data ?? true;
        return InputTextField(
          controller: _confirmPasswordController,
          focusNode: _confirmPasswordNode,
          hintText: AppStrings.confirmPassword,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: bloC.changeEyeButtonStatus,
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkBlue),
          ),
          onChanged: (confirmPassword) {
            bloC.requestModel.confirmPassword = confirmPassword.trim();
            bloC.updateRegisterButtonStatus();
          },
        );
      },
    );
  }

  Widget _buildPasswordInputField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.eyeButtonStatusStream,
      builder: (_, snapshot) {
        bool hidePassword = snapshot.data ?? true;
        return InputTextField(
          controller: _passwordController,
          focusNode: _passwordlNode,
          hintText: AppStrings.password,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: bloC.changeEyeButtonStatus,
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkBlue),
          ),
          onSubmitted: (_) => _confirmPasswordNode.requestFocus(),
          onChanged: (password) {
            bloC.requestModel.password = password.trim();
            bloC.updateRegisterButtonStatus();
          },
        );
      },
    );
  }

  Widget _buildEmailInputField(BuildContext context) {
    return InputTextField(
      controller: _emailController,
      focusNode: _emailNode,
      hintText: AppStrings.email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (value) => _passwordlNode.requestFocus(),
      onChanged: (email) {
        bloC.requestModel.email = email.trim();
        bloC.updateRegisterButtonStatus();
      },
    );
  }

  Widget _buildNameInputField(BuildContext context) {
    return InputTextField(
      controller: _nameController,
      hintText: AppStrings.fullName,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      onSubmitted: (value) => _emailNode.requestFocus(),
      onChanged: (name) {
        bloC.requestModel.name = name.trim();
        bloC.updateRegisterButtonStatus();
      },
    );
  }

  Widget _registerTitle(BuildContext context) {
    return const Text(
      AppStrings.register,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAppLogo(BuildContext context) {
    return Image.asset(
      ImagePaths.appLogo,
      width: MediaQuery.of(context).size.width * 2 / 3,
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.loginBackground),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// send _register request
  /// save user_id if success
  Future<void> _register(BuildContext context) async {
    showLoading(context);
    int userId = await bloC.register();
    Navigator.of(context).pop(); // hide loading
  }
}
