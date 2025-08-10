import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.primaryLight),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(loadingText, style: AppStyles.medium16Primary),
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? postActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
    bool barrierDismissible = true,
  }) {
    List<Widget> actions = [];
    if (postActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null ){
            //   posAction.call();
            // }
            posAction?.call();
          },
          child: Text(postActionName, style: AppStyles.medium16Primary),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null ){
            //   posAction.call();
            // }
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyles.medium16Primary),
        ),
      );
    }
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => AlertDialog(
        actions: actions,
        title: Text(title ?? '', style: AppStyles.medium16black),
        content: Text(message, style: AppStyles.medium16Primary),
      ),
    );
  }
}
