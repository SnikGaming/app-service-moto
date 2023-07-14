import 'package:app/components/calendar/res/colors.dart';
import 'package:app/components/style/text_style.dart';
import 'package:app/functions/random_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<int> test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
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
              child: ListView.builder(
                itemCount: test.length,
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(
                    top: i == 0 ? 20 : 10,
                    left: 20,
                    right: 20,
                    bottom: i == test.length - 1 ? 20 : 0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 120,
                      ),
                      width: size.width,
                      color: randomColor(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${DateTime.now()}',
                                  style: title2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  TextEditingController _noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isNoteValid = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    // Lưu ghi chú, ngày và giờ được chọn
    String note = _noteController.text;

    if (_selectedDate != null && _selectedTime != null) {
      DateTime selectedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      // TODO: Lưu dữ liệu vào cơ sở dữ liệu hoặc thực hiện hành động phù hợp

      Navigator.pop(context); // Đóng hộp thoại
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Vui lòng chọn ngày và giờ trước khi lưu.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          DateTime.now(), // Chỉ cho phép chọn ngày từ ngày hiện tại trở đi
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _onNoteChanged(String value) {
    setState(() {
      _isNoteValid = value.isNotEmpty;
    });
  }

  String _formatVietnameseDate(DateTime date) {
    var format = DateFormat.yMMMMEEEEd('vi_VN');
    return format.format(date);
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm ghi chú'),
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedDate != null
                  ? 'Ngày: ${_formatVietnameseDate(_selectedDate!)}'
                  : 'Chọn ngày'),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: _selectDate,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedTime != null
                  ? 'Giờ: ${_formatTime(_selectedTime!)}'
                  : 'Chọn giờ'),
              IconButton(
                icon: Icon(Icons.access_time),
                onPressed: _selectTime,
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed:
              _isNoteValid && _selectedDate != null && _selectedTime != null
                  ? _saveNote
                  : null,
          child: Text('Lưu'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Hủy'),
        ),
      ],
    );
  }
}
