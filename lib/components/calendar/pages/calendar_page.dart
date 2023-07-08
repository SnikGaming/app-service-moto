// ignore_for_file: library_private_types_in_public_api

import 'dart:core';

import 'package:app/components/calendar/utills/extensions.dart';
import 'package:app/api/booking/api_booking.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:cr_calendar/cr_calendar.dart';

import 'package:flutter/material.dart';

import '../../../api/booking/model.dart' as booking;
import '../res/colors.dart';
import '../utills/constants.dart';
import '../widgets/create_event_dialog.dart';
import '../widgets/day_events_bottom_sheet.dart';
import '../widgets/day_item_widget.dart';
import '../widgets/event_widget.dart';
import '../widgets/week_days_widget.dart';

/// Main calendar page.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _currentDate = DateTime.now();
  final _appbarTitleNotifier = ValueNotifier<String>('');
  final _monthNameNotifier = ValueNotifier<String>('');

  late CrCalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _setTexts(_currentDate.year, _currentDate.month);
    _createExampleEvents();

    loadData();
  }

  loadData() async {
    await APIBooking.fetchBookings();
    List<booking.Data> data = APIBooking.lsData;

    if (mounted) {
      setState(() {
        for (var e in data) {
          _calendarController.addEvent(
            CalendarEventModel(
              id: e.id!,
              eventColor: int.parse(e.color!) == 0
                  ? eventColors[4]
                  : int.parse(e.color!) == 1
                      ? eventColors[0]
                      : eventColors[3],
              name: e.note!,
              addressCal: e.address!,
              begin: DateTime.parse(e.bookingTime!),
              end: DateTime.parse(e.bookingTime!),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _appbarTitleNotifier.dispose();

    _monthNameNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: violet,
        elevation: 0,
        centerTitle: false,
        title: ValueListenableBuilder(
          valueListenable: _appbarTitleNotifier,
          builder: (ctx, value, child) => Text(value),
        ),
        actions: [
          IconButton(
            tooltip: 'Quay về ngày hiện tại',
            icon: const Icon(Icons.calendar_today),
            onPressed: _showCurrentMonth,
          ),
        ],
      ),
      floatingActionButton:
          UserPrefer.getToken() == null || UserPrefer.getToken() == 'null'
              ? null
              : FloatingActionButton(
                  onPressed: _addEvent,
                  child: const Icon(Icons.add),
                ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_booking.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              /// Calendar control row.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _changeCalendarPage(showNext: false);
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _monthNameNotifier,
                    builder: (ctx, value, child) => Text(
                      value,
                      style: const TextStyle(
                          fontSize: 16,
                          color: violet,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      _changeCalendarPage(showNext: true);
                    },
                  ),
                ],
              ),

              /// Calendar view.
              Expanded(
                child: CrCalendar(
                  firstDayOfWeek: WeekDay.monday,
                  eventsTopPadding: 32,
                  initialDate: _currentDate,
                  maxEventLines: 3,
                  controller: _calendarController,
                  forceSixWeek: true,
                  dayItemBuilder: (builderArgument) =>
                      DayItemWidget(properties: builderArgument),
                  weekDaysBuilder: (day) => WeekDaysWidget(day: day),
                  eventBuilder: (drawer) => EventWidget(drawer: drawer),
                  onDayClicked: _showDayEventsInModalSheet,
                  minDate:
                      DateTime.now(), //.subtract(const Duration(days: 1000))
                  maxDate: DateTime.now().add(const Duration(days: 180)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Control calendar with arrow buttons.
  void _changeCalendarPage({required bool showNext}) => showNext
      ? _calendarController.swipeToNextMonth()
      : _calendarController.swipeToPreviousPage();

  void _onCalendarPageChanged(int year, int month) {
    _setTexts(year, month);
  }

  /// Set app bar text and month name over calendar.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _appbarTitleNotifier.value = date.format(kAppBarDateFormat);
    _monthNameNotifier.value = date.format(kMonthFormat);
  }

  /// Show current month page.
  void _showCurrentMonth() {
    _calendarController.goToDate(_currentDate);
  }

  /// Show [CreateEventDialog] with settings for new event.
  Future<void> _addEvent({String? note, DateTime? beginDate, int? id}) async {
    final event = await showDialog(
            context: context,
            builder: (context) =>
                CreateEventDialog(note: note, beginDate: beginDate, id: id))
        .then((value) {});

    if (event != null) {
      _calendarController.addEvent(event);
    }
  }

  void _createExampleEvents() {
    _calendarController = CrCalendarController(
      onSwipe: _onCalendarPageChanged,
      events: [
        // CalendarEventModel(
        //   name: '1 event',
        //   begin: DateTime(now.year, now.month, (now.day).clamp(1, 28)),
        //   end: DateTime(now.year, now.month, (now.day).clamp(1, 28)),
        //   eventColor: eventColors[0],
        // ),
        // CalendarEventModel(
        //   name: '2 event',
        //   begin: DateTime(now.year, now.month - 1, (now.day - 2).clamp(1, 28)),
        //   end: DateTime(now.year, now.month, (now.day + 2).clamp(1, 28)),
        //   eventColor: eventColors[1],
        // ),
        // CalendarEventModel(
        //   name: '3 event',
        //   begin: DateTime(now.year, now.month, (now.day - 3).clamp(1, 28)),
        //   end: DateTime(now.year, now.month + 1, (now.day + 4).clamp(1, 28)),
        //   eventColor: eventColors[2],
        // ),
        // CalendarEventModel(
        //   name: '4 event',
        //   begin: DateTime(now.year, now.month - 1, (now.day).clamp(1, 28)),
        //   end: DateTime(now.year, now.month + 1, (now.day + 5).clamp(1, 28)),
        //   eventColor: eventColors[3],
        // ),
        // CalendarEventModel(
        //   name: '5 event',
        //   begin: DateTime(now.year, now.month + 1, (now.day + 1).clamp(1, 28)),
        //   end: DateTime(now.year, now.month + 2, (now.day + 7).clamp(1, 28)),
        //   eventColor: eventColors[4],
        // ),
      ],
    );
  }

  void _showDayEventsInModalSheet(
      List<CalendarEventModel> events, DateTime day) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        isScrollControlled: true,
        context: context,
        builder: (context) => DayEventsBottomSheet(
              events: events,
              day: day,
              screenHeight: MediaQuery.of(context).size.height,
              addEventCallback: (
                      {String? note, DateTime? beginDate, int? id}) =>
                  _addEvent(note: note, beginDate: beginDate, id: id),
            )).then((value) {});
  }
}
