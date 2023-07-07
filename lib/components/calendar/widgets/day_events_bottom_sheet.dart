// ignore_for_file: use_build_context_synchronously

import 'package:app/api/booking/api_booking.dart';
import 'package:app/components/calendar/utills/extensions.dart';
import 'package:app/components/message/message.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

import '../utills/constants.dart';

/// Draggable bottom sheet with events for the day.
class DayEventsBottomSheet extends StatefulWidget {
  const DayEventsBottomSheet({
    required this.addEventCallback,
    required this.screenHeight,
    required this.events,
    required this.day,
    Key? key,
  }) : super(key: key);
  final Function({String? note, DateTime? beginDate, int? id}) addEventCallback;
  final List<CalendarEventModel> events;
  final DateTime day;
  final double screenHeight;

  @override
  _DayEventsBottomSheetState createState() => _DayEventsBottomSheetState();
}

class _DayEventsBottomSheetState extends State<DayEventsBottomSheet> {
  late List<CalendarEventModel> events;

  @override
  void initState() {
    super.initState();
    events = widget.events;
  }

  void _deleteEvent(int eventId) {
    setState(() {
      events.removeWhere((event) => event.id == eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      expand: false,
      builder: (context, controller) {
        return events.isEmpty
            ? const Center(
                child: Text('Không có sự kiện nào trong ngày hôm nay'),
              )
            : ListView.builder(
                controller: controller,
                itemCount: events.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Text(widget.day.format('dd/MM/yy')),
                    );
                  } else {
                    final event = events[index - 1];
                    return Container(
                      constraints: const BoxConstraints(minHeight: 140),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            children: [
                              Container(
                                color: event.eventColor,
                                width: 6,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.addressCal,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          event.name,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${event.begin.format(kDateRangeFormat)} - ${event.end.format(kDateRangeFormat)}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.addEventCallback(
                                      note: event.name,
                                      beginDate: event.begin,
                                      id: event.id);
                                },
                                child: Container(
                                  height: 140,
                                  color: Colors.yellow,
                                  width: 50,
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  int res = await APIBooking.delBooking(
                                      id: event.id!);
                                  if (res == 200) {
                                    _deleteEvent(event.id!);
                                    Message.success(
                                      message: 'Đã xóa',
                                      context: context,
                                    );
                                  } else {
                                    Message.error(
                                      message: 'Xóa thất bại',
                                      context: context,
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.red,
                                  width: 50,
                                  height: 140,
                                  child: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
      },
    );
  }
}
