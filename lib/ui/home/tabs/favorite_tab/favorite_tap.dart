import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/ui/home/widgets/custom_text_field.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../home_tab/widget/event_item.dart';

class FavoriteTab extends StatelessWidget {
  FavoriteTab({super.key});

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
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
