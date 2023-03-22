import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Event {
  String? title;
  DateTime? date;

  Event({this.title, this.date});
}

class CupertinoCalendar extends StatefulWidget {
  const CupertinoCalendar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CupertinoCalendarState createState() => _CupertinoCalendarState();
}

class _CupertinoCalendarState extends State<CupertinoCalendar> {
  DateTime _selectedDateTime = DateTime.now();
  static final List<Event> _events = [];

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupertino Calendar'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final newDateTime = await showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (context) {
                  return SizedBox(
                      height: 300,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _selectedDateTime,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _selectedDateTime = dateTime;
                          });
                        },
                      ));
                },
              );
              setState(() {
                _selectedDateTime = newDateTime ?? _selectedDateTime;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                DateFormat.yMMMMEEEEd().format(_selectedDateTime),
                style: const TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add note ...',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _events.add(Event(
                          date: _selectedDateTime,
                          title: _textEditingController.text));
                      _textEditingController.clear();
                    });
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_events[index].title!),
                  subtitle: Text(
                    DateFormat.yMMMMEEEEd()
                        .format(_events[index].date!)
                        .toString(),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Delete this event?'),
                                actions: [
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      setState(() {
                                        _events.removeAt(index);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                ],
                              ));
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
              itemCount: _events.length,
            ),
          ),
        ],
      ),
    );
  }
}
