import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  bool? filled;
  Color? fillColor;
  Color? borderColor;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  String? errorText;
  TextStyle? errorStyle;



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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: buildDecorationBorder(radius: 16.0, color: borderColor, side: 2.0),
        focusedBorder: buildDecorationBorder(radius: 16.0, color: borderColor, side: 2.0),
        errorBorder: buildDecorationBorder(radius: 16.0, color: AppColors.red, side: 2.0),
        focusedErrorBorder: buildDecorationBorder(
          radius: 16.0,
          color: AppColors.red, side: 2.0,
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

  OutlineInputBorder buildDecorationBorder({required radius, required color,required side}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: side),
    );
  }
}
