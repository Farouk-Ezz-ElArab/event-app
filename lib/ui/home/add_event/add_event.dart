import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/firebase_utiles.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/model/events.dart';
import 'package:event_app/providers/app_theme_provider.dart';
import 'package:event_app/ui/home/add_event/widgets/date_or_time_widget.dart';
import 'package:event_app/ui/home/widgets/custom_elevated_button.dart';
import 'package:event_app/ui/home/widgets/custom_text_field.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../providers/event_list_provider.dart';
import '../tabs/home_tab/widget/event_tab_item.dart';

class AddEvent extends StatefulWidget {
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  bool isSent = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? formatedDate = '';
  TimeOfDay? selectedTime;
  String formatedTime = '';
  String selectedImage = '';
  String selectedEventName = '';
  late EventsListProvider eventsListProvider;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    eventsListProvider = Provider.of<EventsListProvider>(context);

    List<String> eventsNameList = [
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
    List<String> eventImagesList = [
      AppAssets.sportImage,
      AppAssets.birthdayImage,
      AppAssets.meetingImage,
      AppAssets.gamingImage,
      AppAssets.workshopImage,
      AppAssets.bookImage,
      AppAssets.exhibitionImage,
      AppAssets.holidayImage,
      AppAssets.eatingImage,
    ];
    selectedImage = eventImagesList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium20Primary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(selectedImage),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.06,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: EventTabItem(
                          borderColor: AppColors.primaryLight,
                          selectedTextStyle: Theme.of(
                            context,
                          ).textTheme.labelMedium!,
                          unSelectedTextStyle: AppStyles.medium16Primary,
                          isSelected: selectedIndex == index,
                          eventName: eventsNameList[index],
                          selectedBgColor: AppColors.primaryLight,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.02);
                    },
                    itemCount: eventsNameList.length,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_title;
                          }
                          return null;
                        },
                        boarderSideColor:
                            ThemeMode.dark == themeProvider.appTheme
                            ? AppColors.primaryLight
                            : AppColors.greyColor,
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        controller: titleController,
                        prefixIcon: Image.asset(
                          AppAssets.editIcon,
                          color: Theme.of(context).cardColor,
                        ),
                        hintText: AppLocalizations.of(context)!.event_title,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_description;
                          }
                          return null;
                        },
                        boarderSideColor:
                            ThemeMode.dark == themeProvider.appTheme
                            ? AppColors.primaryLight
                            : AppColors.greyColor,
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        maxLines: 4,
                        controller: descriptionController,
                        hintText: AppLocalizations.of(
                          context,
                        )!.event_description,
                      ),
                      DateOrTimeWidget(
                        iconDateOrTime: AppAssets.dateIcon,
                        eventDateOrTime: AppLocalizations.of(
                          context,
                        )!.event_date,
                        chooseDateOrTime: selectedDate == null
                            ? AppLocalizations.of(context)!.choose_date
                            : formatedDate!,
                        //'${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}',
                        onChooseDateOrTimeClick: chooseDate,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: selectedDate == null && isSent,
                            child: Text(
                              AppLocalizations.of(context)!.please_choose_date,
                              style: AppStyles.bold14Primary.copyWith(
                                color: AppColors.redColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DateOrTimeWidget(
                        iconDateOrTime: AppAssets.timeIcon,
                        eventDateOrTime: AppLocalizations.of(
                          context,
                        )!.event_time,
                        chooseDateOrTime: selectedTime == null
                            ? AppLocalizations.of(context)!.choose_time
                            : formatedTime,
                        onChooseDateOrTimeClick: chooseTime,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: selectedTime == null && isSent,
                            child: Text(
                              AppLocalizations.of(context)!.please_choose_time,
                              style: AppStyles.bold14Primary.copyWith(
                                color: AppColors.redColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: height * 0.013),
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
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        buttonText: AppLocalizations.of(context)!.update_event,
                        onPressed: addEvent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    if (selectedDate != null) {
      formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formatedTime = selectedTime!.format(context);
    }
    setState(() {});
  }

  void addEvent() {
    isSent = true;
    setState(() {});
    if (formKey.currentState!.validate() && selectedTime != null &&
        selectedDate != null) {
      Event event = Event(
        dateTime: selectedDate!,
        description: descriptionController.text,
        title: titleController.text,
        eventName: selectedEventName,
        image: selectedImage,
        time: formatedTime,
      );
      FirebaseUtils.addEventToFireStore(event).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          //todo: snack bar, alert dialog, toast
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.event_added_successfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.whiteColor,
            textColor: AppColors.primaryLight,
            fontSize: 16.0,
          );
          eventsListProvider.getAllEvents();
          Navigator.pop(context);
        },
      );
    }
  }
}
