// ignore_for_file: use_build_context_synchronously

import 'package:app/components/calendar/res/colors.dart';
import 'package:app/components/style/text_style.dart';
import 'package:app/functions/random_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../api/booking/api_booking.dart';
import '../../../../api/booking/model.dart' as booking;
import '../../../../components/convert/str_and_datetime.dart';
import '../../../../components/message/message.dart';
import '../../../../components/value_app.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int type = 1;
  bool isBackground = false;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await APIBooking.fetchBookings(type: type);
    List<booking.Data> data = APIBooking.lsData;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: violet,
        actions: [
          IconButton(
            icon: const Icon(Icons.change_circle),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => NoteDialog(),
          ).then(
            (value) => loadData(),
          );
        },
        label: const Icon(Icons.add),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            BackgroundCalendar(size: size),
            SizedBox(
              height: size.height,
              width: size.width,
              child: isBackground
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: APIBooking.lsData.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          List<String> lsType = [
                            'Theo ngày tạo',
                            'Theo ngày đặt'
                          ];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(
                                lsType.length,
                                (index) => Padding(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                        right:
                                            lsType.length - 1 == index ? 20 : 5,
                                        top: 20,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (mounted) {
                                            setState(() {
                                              isBackground = true;
                                              type = index + 1;
                                            });
                                          }
                                          loadData();
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: type - 1 == index
                                                  ? Colors.black
                                                  : Colors.white,
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Center(
                                              child: Text(
                                            lsType[index],
                                            style: title1.copyWith(
                                              fontSize: 14,
                                              color: type - 1 == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )),
                                        ),
                                      ),
                                    )),
                          );
                        } else {
                          // Dữ liệu từ danh sách APIBooking.lsData
                          booking.Data dataBooking =
                              APIBooking.lsData[index - 1];
                          String formattedDate = DateFormat('dd-MM-yyyy')
                              .format(
                                  DateTime.parse('${dataBooking.bookingTime}'));
                          String formattedTime = DateFormat('HH:mm:ss').format(
                              DateTime.parse('${dataBooking.bookingTime}'));
                          String createAt = DateFormat('dd-MM-yyyy').format(
                              DateTime.parse('${dataBooking.createdAt}'));
                          Future.delayed(const Duration(seconds: 3))
                              .then((value) {
                            if (mounted) {
                              setState(() {
                                isBackground = false;
                              });
                            }
                          });
                          return Padding(
                            padding: EdgeInsets.only(
                              top: index == 1 ? 20 : 10,
                              left: 20,
                              right: 20,
                              bottom:
                                  index == APIBooking.lsData.length ? 20 : 0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 120),
                                width: size.width,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      style: title1.copyWith(fontSize: 14),
                                      children: [
                                        const TextSpan(
                                          text: 'Ngày: ',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        TextSpan(
                                          text: formattedDate,
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                        const TextSpan(
                                          text: '\nThời gian: ',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        TextSpan(
                                          text: formattedTime,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                        const TextSpan(
                                          text: '\n\nNội dung:',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        TextSpan(
                                          text: ' ${dataBooking.note!}',
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                        const TextSpan(
                                          text: '\nĐịa chỉ:',
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                        TextSpan(
                                          text: ' ${dataBooking.address!}',
                                          style: const TextStyle(
                                              color: Colors.orange),
                                        ),
                                        const TextSpan(
                                          text: '\nThời gian tạo:',
                                          style:
                                              TextStyle(color: Colors.purple),
                                        ),
                                        TextSpan(
                                          text: ' $createAt',
                                          style: const TextStyle(
                                              color: Colors.purple),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundCalendar extends StatelessWidget {
  const BackgroundCalendar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}

class NoteDialog extends StatefulWidget {
  final bool isEditMode;
  final String? initialNote;
  final DateTime? initialDateTime;

  NoteDialog({
    this.isEditMode = false,
    this.initialNote,
    this.initialDateTime,
  });

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  TextEditingController _noteController = TextEditingController();
  DateTime? _selectedDateTime;
  bool _isNoteValid = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
    _selectedDateTime = widget.initialDateTime;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_selectedDateTime != null) {
      if (_selectedDateTime!.isBefore(DateTime.now())) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content: const Text(
                  'Vui lòng chọn thời gian không nhỏ hơn thời gian hiện tại.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      Map<String, String> data = {
        'note': _noteController.text,
        'booking_time': _selectedDateTime!.toIso8601String(),
        "address": txtAddressCty,
        "service": "abc",
        "mechanic_id": '3'
      };
      print('---------->Data ${data}');

      if (widget.isEditMode) {
        // TODO: Cập nhật dữ liệu
        // int res = await APIBooking.updateBooking(data: data, id: widget.id!);
        // if (res == 200) {
        //   Message.success(message: 'Chỉnh sửa thành công.', context: context);
        //   Navigator.pop(context);
        // } else {
        //   Message.error(message: 'Chỉnh sửa thất bại.', context: context);
        // }
      } else {
        // TODO: Thêm mới dữ liệu
        int res = await APIBooking.createBooking(data: data);
        if (res == 200) {
          Message.success(
              message: 'Thêm ghi chú thành công.', context: context);
          Navigator.pop(context);
        } else {
          Message.error(message: 'Thêm ghi chú thất bại.', context: context);
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Vui lòng chọn thời gian trước khi lưu.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedDateTime != null
            ? TimeOfDay.fromDateTime(_selectedDateTime!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _onNoteChanged(String value) {
    setState(() {
      _isNoteValid = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditMode ? 'Chỉnh sửa ghi chú' : 'Thêm ghi chú'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _noteController,
            onChanged: _onNoteChanged,
            decoration: InputDecoration(
              hintText: 'Nhập ghi chú',
              errorText: _isNoteValid ? null : 'Ghi chú không được để trống',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedDateTime != null
                  ? 'Thời gian:\n${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDateTime!)}'
                  : 'Chọn thời gian'),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _selectDateTime,
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed:
              _isNoteValid && _selectedDateTime != null ? _saveNote : null,
          child: Text(widget.isEditMode ? 'Lưu' : 'Thêm'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateTime = DateTime(year, month, day);
    return dateTime.isAtSameMomentAs(today);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  bool isBefore(TimeOfDay otherTime) {
    if (this.hour < otherTime.hour) {
      return true;
    } else if (this.hour == otherTime.hour && this.minute < otherTime.minute) {
      return true;
    } else {
      return false;
    }
  }
}
