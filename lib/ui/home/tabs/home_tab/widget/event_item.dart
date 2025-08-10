import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/providers/event_list_provider.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/events.dart';

class EventItem extends StatelessWidget {
  Event event;

  EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventsListProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      height: height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: AppColors.primaryLight),
        image: DecorationImage(
          image: AssetImage(event.image),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            padding: EdgeInsets.symmetric(
              vertical: height * 0.001,
              horizontal: width * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(event.dateTime.day.toString(),
                    style: AppStyles.bold20Primary),
                Text(DateFormat('MMM').format(event.dateTime),
                    style: AppStyles.bold14Primary),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).dividerColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                InkWell(
                  onTap: () {
                    eventListProvider.updateIsFavorite(event);
                  },
                  child: !event.isFavorite ? Image.asset(
                    AppAssets.favoriteIcon,
                    color: AppColors.primaryLight,
                  ) : Image.asset(
                    AppAssets.selectedFavoritePr,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
