import 'package:flutter/material.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final int? maxLength;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final void Function()? onTap;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final Color? fillColor;

  const InputTextField(
      {Key? key,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.onChanged,
      this.onSubmitted,
      this.hintText,
      this.textCapitalization = TextCapitalization.none,
      this.maxLength,
      this.suffixIcon,
      this.readOnly = false,
      this.obscureText = false,
      this.onTap,
      this.textInputAction,
      this.autofocus = false,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyText2,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      cursorColor: AppColors.black,
      maxLength: maxLength,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        counterText: '',
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
