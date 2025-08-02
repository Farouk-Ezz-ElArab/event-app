import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/event_list_provider.dart';
import 'package:event_app/ui/home/widgets/custom_text_field.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_tab/widget/event_item.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  TextEditingController searchController = TextEditingController();

  late EventsListProvider eventListProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventListProvider.getAllFavoriteEventsFromFireStore();
    });
  }

  @@override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
    eventListProvider = Provider.of<EventsListProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.012,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
            child: CustomTextField(
              controller: searchController,
              hintStyle: AppStyles.medium16Primary,
              //labelText: AppLocalizations.of(context)!.search_for_event,
              boarderSideColor: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_for_event,
              //labelStyle: AppStyles.bold14Primary,
              prefixIcon: Image.asset(AppAssets.searchIcon),
            ),
          ),
          Expanded(
            child: eventListProvider.favoriteEventList.isEmpty ? Center(
                child: Text(AppLocalizations.of(context)!.no_results,
                  style: AppStyles.bold14Primary,))
                : ListView.separated(
              padding: EdgeInsets.only(top: screenSize.height * 0.015),
              itemBuilder: (context, index) {
                return EventItem(
                    event: eventListProvider.favoriteEventList[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: screenSize.height * 0.02);
              },
              itemCount: eventListProvider.favoriteEventList.length,
            ),
          ),
        ],
      ),
    );
  }
}
