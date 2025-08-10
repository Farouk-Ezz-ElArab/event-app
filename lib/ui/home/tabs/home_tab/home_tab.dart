import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/event_list_provider.dart';
import 'package:event_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:event_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventsListProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider.getEventsNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents();
    }

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,
                ),
                Text('Farouk Ezz El-Arab', style: AppStyles.bold24White),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                if (themeProvider.appTheme == ThemeMode.dark) {
                  themeProvider.changeTheme(ThemeMode.light);
                } else {
                  themeProvider.changeTheme(ThemeMode.dark);
                }
              },
              child: ImageIcon(
                AssetImage(AppAssets.lightIcon),
                color: AppColors.whiteColor,
                size: 35,
              ),
            ),
            InkWell(
              onTap: () {
                if (languageProvider.appLanguage == 'en') {
                  languageProvider.changeLanguage('ar');
                } else {
                  languageProvider.changeLanguage('en');
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: screenSize.width * 0.01),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  languageProvider.appLanguage.toUpperCase(),
                  style: AppStyles.bold14Primary,
                ),
              ),
            ),
          ],
        ),
        bottom: AppBar(
          //automaticallyImplyLeading: false,
          toolbarHeight: screenSize.height * 0.1,
          backgroundColor: Theme.of(context).primaryColor,
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.mapIcon),
                  SizedBox(width: screenSize.width * 0.015),
                  Text('Cairo , Egypt', style: AppStyles.medium14White),
                ],
              ),
              DefaultTabController(
                length: eventListProvider.eventsNameList.length,
                child: TabBar(
                  onTap: (index) {
                    eventListProvider.changeSelectedIndex(index);
                  },
                  dividerColor: AppColors.transparentColor,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: AppColors.transparentColor,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.015,
                  ),
                  isScrollable: true,
                  tabs: eventListProvider.eventsNameList.map((eventName) {
                    return EventTabItem(
                      selectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineMedium!,
                      unSelectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineSmall!,
                      selectedBgColor: Theme.of(context).focusColor,
                      isSelected:
                          eventListProvider.selectedIndex ==
                          eventListProvider.eventsNameList.indexOf(eventName),
                      eventName: eventName,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Visibility(
        replacement: Center(
          child: Text(
            AppLocalizations.of(context)!.no_events_yet,
            style: AppStyles.medium16Primary,
          ),
        ),
        visible: eventListProvider.filterEventsList.isNotEmpty,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: screenSize.height * 0.015),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.eventDetailsScreenRouteName,
                          arguments: eventListProvider.filterEventsList[index]);
                    },
                    child: EventItem(
                      event: eventListProvider.filterEventsList[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: screenSize.height * 0.02);
                },
                itemCount: eventListProvider.filterEventsList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
