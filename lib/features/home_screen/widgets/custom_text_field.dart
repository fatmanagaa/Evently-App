import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

typedef onChanged = void Function(String);
typedef onValidator = String? Function(String?);

class CustomTextField extends StatelessWidget {
  final bool? filled;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function(String)? onChanged;
  final onValidator? Validator;
  final bool obscureText;
  final TextInputType keyboardType;

  CustomTextField({
    super.key,
    this.filled,
    this.fillColor,
    required this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.errorText,
    this.errorStyle,
    this.style,
    this.controller,
    this.maxLines,
    this.onChanged,
    this.Validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,

      validator: Validator,
      obscureText: obscureText,

      onChanged: onChanged,
      controller: controller,
      style: style,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder: buildDecorationBorder(
          radius: 16.0,
          color: borderColor,
          side: 2.0,
        ),
        focusedBorder: buildDecorationBorder(
          radius: 16.0,
          color: borderColor,
          side: 2.0,
        ),
        errorBorder: buildDecorationBorder(
          radius: 16.0,
          color: AppColors.red,
          side: 2.0,
        ),
        focusedErrorBorder: buildDecorationBorder(
          radius: 16.0,
          color: AppColors.red,
          side: 2.0,
        ),
        filled: filled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        errorText: errorText,
        errorStyle: errorStyle,
      ),
    );
  }

  OutlineInputBorder buildDecorationBorder({
    required radius,
    required color,
    required side,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: side),
    );
  }
}
