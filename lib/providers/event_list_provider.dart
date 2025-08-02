import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../firebase_utiles.dart';
import '../l10n/app_localizations.dart';
import '../model/events.dart';
import '../utils/app_colors.dart';

class EventsListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
  List<String> eventsNameList = [];
  List<Event> favoriteEventList = [];
  int selectedIndex = 0;
  List<String> eventsNameListForArabic = [
    'All',
    'Sport',
    'Birthday',
    'Meeting',
    'Gaming',
    'Workshop',
    'Book Club',
    'Exhibition',
    'Holiday',
    'Eating',
  ];

  void getEventsNameList(BuildContext context) {
    eventsNameList = [
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
  }

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    querySnapshot.docs;
    eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
    filterEventsList = eventsList;
    filterEventsList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEvents() async {
    var querySnapShot = await FirebaseUtils.getEventCollection().get();
    querySnapShot.docs.map((doc) => doc.data()).toList();
    filterEventsList = eventsList
        .where(
          (event) => event.eventName == eventsNameListForArabic[selectedIndex],
        )
        .toList();
    filterEventsList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEventsFromFireStore() async {
    var querySnapShot = await FirebaseUtils.getEventCollection()
        .orderBy('dateTime')
        .where('eventName', isEqualTo: eventsNameListForArabic[selectedIndex])
        .get();
    filterEventsList = querySnapShot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  void updateIsFavorite(Event event) {
    FirebaseUtils.getEventCollection()
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite})
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            Fluttertoast.showToast(
              msg: 'Event Updated successfully',
              // msg: AppLocalizations.of(context)!.event_added_successfully,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.greenColor,
              textColor: AppColors.whiteColor,
              fontSize: 16.0,
            );
          },
        );
    selectedIndex == 0 ? getAllEvents() : getFilterEvents();
    getAllFavoriteEvents();
    notifyListeners();
  }

  void getAllFavoriteEvents() async {
    var querySnapshot = await FirebaseUtils.getEventCollection().get();
    favoriteEventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    favoriteEventList = favoriteEventList.where((event) {
      return event.isFavorite;
    }).toList();

    notifyListeners();
  }

  void getAllFavoriteEventsFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getEventCollection()
        .orderBy('dateTime')
        .where('isFavorite', isEqualTo: true)
        .get();
    favoriteEventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
  }
}
