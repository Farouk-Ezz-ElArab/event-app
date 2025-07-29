import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

class EventTabItem extends StatelessWidget {
  bool isSelected;
  String eventName;
  Color? selectedBgColor;
  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;
  Color? borderColor;

  EventTabItem({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.selectedBgColor,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: screenSize.width * 0.05),
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.004,
      ),
      decoration: BoxDecoration(
        color: isSelected ? selectedBgColor : AppColors.transparentColor,
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: borderColor ?? Theme.of(context).focusColor,
          width: 2,
        ),
      ),
      child: Text(
        eventName,
        style: isSelected ? selectedTextStyle : unSelectedTextStyle,
      ),
    );
  }
}
