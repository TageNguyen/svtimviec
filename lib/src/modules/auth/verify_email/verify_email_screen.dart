import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/auth/verify_email/verify_email_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _verifyCodeController = TextEditingController();

  late VerifyEmailBloC bloC;

  @override
  void initState() {
    bloC = context.read<VerifyEmailBloC>();
    super.initState();
  }

  @override
  void dispose() {
    _verifyCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _verifyTitle(context),
            const SizedBox(height: 8),
            _verifyDescription(context),
            const SizedBox(height: 40),
            _buildVerifyCodeInputField(context),
            const SizedBox(height: 16),
            Align(
                alignment: Alignment.centerRight,
                child: _buildVerifyButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.verifyButtonStatusStream,
      builder: (_, snapshot) {
        bool isEnable = snapshot.data ?? false;
        return ElevatedButton(
          onPressed: isEnable
              ? () {
                  _verifyEmail(context).catchError((error) {
                    Navigator.pop(context); // hide loading
                    showNotificationDialog(context, error.message);
                  });
                }
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(AppStrings.verify),
              SizedBox(width: 8.0),
              Icon(Icons.arrow_forward_rounded),
            ],
          ),
        );
      },
    );
  }

  Widget _verifyTitle(BuildContext context) {
    return const Text(
      AppStrings.verifyEmail,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _verifyDescription(BuildContext context) {
    return const Text(
      AppStrings.pleaseEnterTheCodeSentToYourEmail,
      style: TextStyle(
        color: AppColors.grey,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildVerifyCodeInputField(BuildContext context) {
    return InputTextField(
      controller: _verifyCodeController,
      autofocus: true,
      hintText: AppStrings.verifyCode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      fillColor: AppColors.tintLighter,
      onChanged: (verifyCode) => bloC.verifyCode = verifyCode,
    );
  }

  /// send verify email request
  Future<void> _verifyEmail(BuildContext context) async {
    showLoading(context);
    await bloC.verifyEmail();
    Navigator.of(context).pop(); // hide loading
    debugPrint('verifyEmail success --> move to main page');
    // Navigator.pushNamedAndRemoveUntil(context, RouteNames.verifyEmail,
    // arguments: userId); // move to verify email page
  }
}
