import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  bool isSelected;
  Color selectedColor;
  Color unSelectedColor;

  String eventsName;
  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;

  TabWidget({
    super.key,
    required this.isSelected,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.eventsName,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: selectedColor, width: 2),
        color: isSelected ? selectedColor : unSelectedColor,
      ),
      child: Center(
        child: Text(
          eventsName,
          style: isSelected ? selectedTextStyle : unSelectedTextStyle,
        ),
      ),
    );
  }
}