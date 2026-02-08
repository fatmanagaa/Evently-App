
import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
TextStyle? getLargeTitle(){
  return Theme.of(this).textTheme.headlineLarge;

}
}