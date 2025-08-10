import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/app_language_provider.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.03,
        horizontal: screenSize.width * 0.04
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en'?
            getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english):
            getUnselectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english),
          ),
          SizedBox(height: screenSize.height * 0.02,),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar'?
            getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic):
            getUnselectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textLanguage}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textLanguage,
          style: AppStyles.bold20Primary,
        ),
        Icon(Icons.check, color: AppColors.primaryLight, size: 35,)
      ],
    );
  }
  Widget getUnselectedLanguageItem({required String textLanguage}){
    return Row(
      children: [
        Text(
          textLanguage,
          style: AppStyles.bold20Black,
        ),
      ],
    );
  }
}
