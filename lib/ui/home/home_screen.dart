import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/ui/home/tabs/favorite_tab/favorite_tap.dart';
import 'package:event_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:event_app/ui/home/tabs/map_tab/map_tap.dart';
import 'package:event_app/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab(),];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        color: Theme.of(context).primaryColor,
        child: BottomNavigationBar(
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          items: [
            buildBottomNavigationBarItem(
              selectedIconName: AppAssets.homeIcon,
              label: AppLocalizations.of(context)!.home,
              unselectedIconName: AppAssets.selectedHome,
              index: 0,
            ),
            buildBottomNavigationBarItem(
              selectedIconName: AppAssets.mapIcon,
              label: AppLocalizations.of(context)!.map,
              unselectedIconName: AppAssets.selectedMap,
              index: 1,
            ),
            buildBottomNavigationBarItem(
              selectedIconName: AppAssets.favoriteIcon,
              label: AppLocalizations.of(context)!.favorites,
              unselectedIconName: AppAssets.selectedFavorite,
              index: 2,
            ),
            buildBottomNavigationBarItem(
              selectedIconName: AppAssets.personProfileIcon,
              label: AppLocalizations.of(context)!.profile,
              unselectedIconName: AppAssets.selectedProfilePerson,
              index: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 35, color: AppColors.whiteColor, ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String selectedIconName,
    required String label,
    required String unselectedIconName,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? unselectedIconName : selectedIconName,
        ),
      ),
      label: label,
    );
  }
}
