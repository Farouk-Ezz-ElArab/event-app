import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:event_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  int selectedIndex = 0;

  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;

    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
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
            ImageIcon(
              AssetImage(AppAssets.lightIcon),
              color: AppColors.whiteColor,
              size: 35,
            ),
            Container(
              margin: EdgeInsets.only(left: screenSize.width * 0.01),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('En', style: AppStyles.bold14Primary),
            ),
          ],
        ),
        bottom: AppBar(
          //automaticallyImplyLeading: false,
          toolbarHeight: screenSize.height * 0.1,
          backgroundColor: Theme
              .of(context)
              .primaryColor,
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
                length: eventsNameList.length,
                child: TabBar(
                  onTap: (index) {
                    widget.selectedIndex = index;
                    setState(() {});
                  },
                  dividerColor: AppColors.transparentColor,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: AppColors.transparentColor,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.015,
                  ),
                  isScrollable: true,
                  tabs: eventsNameList.map((eventName) {
                    return EventTabItem(
                      selectedTextStyle: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium!,
                      unSelectedTextStyle: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall!,
                      selectedBgColor: Theme
                          .of(context)
                          .focusColor,
                      isSelected:
                      widget.selectedIndex ==
                          eventsNameList.indexOf(eventName),
                      eventName: eventName,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: screenSize.height * 0.015),
              itemBuilder: (context, index) {
                return EventItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: screenSize.height * 0.02);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
