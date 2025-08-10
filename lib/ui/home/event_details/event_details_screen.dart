import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/firebase_utiles.dart';
import 'package:event_app/model/events.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/event_list_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../widgets/custom_elevated_button.dart';

class EventDetailsScreen extends StatefulWidget {
  EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Event? event;

  @override
  Widget build(BuildContext context) {
    final selectedEvent =
        event ?? ModalRoute.of(context)!.settings.arguments as Event;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventsListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyles.medium20Primary,
        ),
        actions: [
          InkWell(
            onTap: () async {
              Event? modelAfter =
                  await Navigator.of(context).pushNamed(
                        AppRoutes.editEventScreenRouteName,
                        arguments: selectedEvent,
                      )
                      as Event?;
              if (modelAfter != null) {
                event = modelAfter;
                setState(() {});
              }
            },
            child: Icon(Icons.edit, color: AppColors.primaryLight, size: 30),
          ),
          SizedBox(width: width * 0.02),
          InkWell(
            onTap: () {
              FirebaseUtils.deleteEventFromFireStore(selectedEvent.id);
              //Navigator.popUntil(context, (route) => AppRoutes.homeScreenRouteName == route.settings.name,);
              eventListProvider.getFilterEvents();
              Navigator.pop(context);
            },
            child: Icon(Icons.delete, color: AppColors.redColor, size: 30),
          ),
          SizedBox(width: width * 0.02),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.02),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(selectedEvent.image),
                ),
                SizedBox(height: height * 0.02),
                Text(selectedEvent.title, style: AppStyles.medium24Primary),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16),
                    ),
                    elevation: 0,
                    backgroundColor: AppColors.transparentColor,
                    side: BorderSide(color: AppColors.primaryLight),
                    padding: EdgeInsets.all(width * 0.02),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    // TODO: map screen
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(width * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight,
                        ),
                        child: ImageIcon(
                          AssetImage(AppAssets.dateIcon),
                          size: 30,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${selectedEvent.dateTime.day}  ${DateFormat('MMM').format(selectedEvent.dateTime)} ${selectedEvent.dateTime.year}\n',
                              style: AppStyles.medium16Primary,
                            ),
                            TextSpan(
                              text: selectedEvent.time,
                              style: AppStyles.medium16black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  isLocationButton: true,
                  leadingIcon: Container(
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryLight,
                    ),
                    child: ImageIcon(
                      AssetImage(AppAssets.locationIcon),
                      size: 30,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  rowMainAxesAlignment: MainAxisAlignment.start,
                  buttonTextStyle: AppStyles.medium16Primary,
                  buttonColor: AppColors.transparentColor,
                  buttonText: AppLocalizations.of(context)!.cairo_egypt,
                  onPressed: () {
                    //todo: map screen
                  },
                  borderColor: AppColors.primaryLight,
                ),
                SizedBox(height: height * 0.05),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: AppStyles.medium16black,
                ),
                SizedBox(height: height * 0.02),
                Text(selectedEvent.description, style: AppStyles.medium16black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
