import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  String iconDateOrTime;
  String eventDateOrTime;
  String chooseDateOrTime;
  VoidCallback onChooseDateOrTimeClick;

  DateOrTimeWidget({
    super.key,
    required this.iconDateOrTime,
    required this.eventDateOrTime,
    required this.chooseDateOrTime,
    required this.onChooseDateOrTimeClick,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconDateOrTime,
          color: Theme.of(context).unselectedWidgetColor,
        ),
        SizedBox(width: width * 0.04),
        Text(eventDateOrTime, style: Theme.of(context).textTheme.titleLarge),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTimeClick,
          child: Text(chooseDateOrTime, style: AppStyles.medium16Primary),
        ),
      ],
    );
  }
}
