import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/modules/auth/login/login_bloc.dart';
import 'package:student_job_applying/src/modules/auth/widgets/type_role_checkbox.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/image_paths.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

/// login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  late LoginBloC bloC;
  late UserManager userManager;

  @override
  void initState() {
    bloC = context.read<LoginBloC>();
    userManager = context.read<UserManager>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return KeyboardDismisser(
      child: Scaffold(
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
                  SizedBox(height: screenSize.height / 8),
                  Align(
                    alignment: Alignment.center,
                    child: _buildAppLogo(context),
                  ),
                  SizedBox(height: screenSize.height / 8),
                  _loginTitle(context),
                  const SizedBox(height: 28.0),
                  _buildEmailInputField(context),
                  const SizedBox(height: 12.0),
                  _buildPasswordInputField(context),
                  const SizedBox(height: 5.0),
                  TypeRoleCheckBox(
                      title: AppStrings.loginAsRecruiter,
                      onChanged: (type) {
                        bloC.typeRole = type;
                      }),
                  const SizedBox(height: 32.0),
                  _buildButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo(BuildContext context) {
    return Image.asset(
      ImagePaths.appLogo,
      width: MediaQuery.of(context).size.width * 2 / 3,
    );
  }

  Widget _loginTitle(BuildContext context) {
    return const Text(
      AppStrings.login,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailInputField(BuildContext context) {
    return InputTextField(
      controller: _emailController,
      hintText: AppStrings.email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (value) => _passwordNode.requestFocus(),
      onChanged: (email) => bloC.email = email,
    );
  }

  Widget _buildPasswordInputField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.eyeButtonStatusStream,
      builder: (_, snapshot) {
        bool hidePassword = snapshot.data ?? true;
        return InputTextField(
          controller: _passController,
          focusNode: _passwordNode,
          hintText: AppStrings.password,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: bloC.changeEyeButtonStatus,
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkBlue),
          ),
          onChanged: (password) => bloC.password = password,
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLoginButton(context),
        _buildRegisterButton(context),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.loginButtonStatusStream,
      builder: (_, snapshot) {
        bool isEnable = snapshot.data ?? false;
        return ElevatedButton(
          onPressed: isEnable
              ? () {
                  _login(context).catchError((error) {
                    Navigator.pop(context); // hide loading
                    showNotificationDialog(context, error.message);
                  });
                }
              : null,
          child: const Text(AppStrings.login),
        );
      },
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // move to register page
        Navigator.pushNamed(context, RouteNames.register);
      },
      child: const Text(AppStrings.registerAccount),
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

  /// send login request
  /// save token if success
  Future<void> _login(BuildContext context) async {
    showLoading(context);
    String token = await bloC.login();
    await userManager.setAccessToken(token);
    Navigator.of(context).pop(); // hide loading
  }
}
