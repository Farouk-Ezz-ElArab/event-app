import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Color buttonColor;
  Color? borderColor;
  TextStyle? buttonTextStyle;
  String buttonText;
  VoidCallback onPressed;
  Widget? leadingIcon;
  MainAxisAlignment rowMainAxesAlignment;
  bool isLocationButton;

  CustomElevatedButton({
    this.isLocationButton = false,
    this.rowMainAxesAlignment = MainAxisAlignment.center,
    super.key,
    this.leadingIcon,
    this.buttonTextStyle,
    this.buttonColor = AppColors.primaryLight,
    required this.buttonText,
    required this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: isLocationButton
              ? screenSize.height * 0.01
              : screenSize.height * 0.02,
          horizontal: screenSize.width * 0.02,
          //horizontal: screenSize.width * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.primaryLight,
          ),
        ),
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: !isLocationButton
          ? Row(
              mainAxisAlignment: rowMainAxesAlignment,
              children: [
                leadingIcon ?? SizedBox(),
                leadingIcon != null
                    ? SizedBox(width: screenSize.width * 0.01)
                    : SizedBox(),
                Text(
                  buttonText,
                  style: buttonTextStyle ?? AppStyles.medium20White,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: rowMainAxesAlignment,
              children: [
                leadingIcon ?? SizedBox(),
                leadingIcon != null
                    ? SizedBox(width: screenSize.width * 0.01)
                    : SizedBox(),
                Text(
                  buttonText,
                  style: buttonTextStyle ?? AppStyles.medium20White,
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: AppColors.primaryLight),
              ],
            ),
    );
  }
}
