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
  final TextStyle? hintStyle;
  final int? maxLines;
  final bool? enabled;

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
      this.textInputAction = TextInputAction.next,
      this.autofocus = false,
      this.fillColor,
      this.hintStyle,
      this.maxLines = 1,
      this.enabled = true})
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
      maxLines: maxLines,
      minLines: 1,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        counterText: '',
        suffixIcon: suffixIcon,
        fillColor: fillColor,
      ),
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
