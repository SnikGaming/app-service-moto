// ignore_for_file: use_build_context_synchronously

import 'package:app/components/calendar/utills/extensions.dart';

import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

import '../../style/text_style.dart';
import '../utills/constants.dart';

/// Draggable bottom sheet with events for the day.
class DayEventsBottomSheet extends StatefulWidget {
  const DayEventsBottomSheet({
    required this.screenHeight,
    required this.events,
    required this.day,
    Key? key,
  }) : super(key: key);

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
                                constraints:
                                    const BoxConstraints(minHeight: 100),
                              ),
                              // Expanded(
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(left: 16),
                              //     child: Align(
                              //       alignment: Alignment.centerLeft,
                              //       child: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             event.addressCal,
                              //             style: const TextStyle(fontSize: 16),
                              //           ),
                              //           Text(
                              //             event.name,
                              //             style: const TextStyle(fontSize: 16),
                              //           ),
                              //           const SizedBox(height: 8),
                              //           Text(
                              //             '${event.begin.format(kDateRangeFormat)} - ${event.end.format(kDateRangeFormat)}',
                              //             style: const TextStyle(fontSize: 14),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: RichText(
                                text: TextSpan(
                                  style: title1.copyWith(fontSize: 14),
                                  children: [
                                    const TextSpan(
                                      text: 'Nội dung:',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    TextSpan(
                                      text: ' ${event.name!}',
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                                    const TextSpan(
                                      text: '\n\nĐịa chỉ:',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    TextSpan(
                                      text: ' ${event.addressCal}',
                                      style:
                                          const TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                ),
                              )),
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
