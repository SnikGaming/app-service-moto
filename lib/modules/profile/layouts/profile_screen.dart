import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Nguyễn Văn A';
  String _phoneNumber = '0123456789';
  String _email = 'nguyenvana@gmail.com';
  String _profileImage =
      'https://scontent.fsgn5-12.fna.fbcdn.net/v/t39.30808-1/332374699_1217447262204058_297060313736937850_n.jpg?stp=dst-jpg_s200x200&_nc_cat=103&ccb=1-7&_nc_sid=7206a8&_nc_ohc=qQkorii9GgsAX-keDmL&_nc_ht=scontent.fsgn5-12.fna&oh=00_AfAhJpijsM-9T7yTSqLjvAD9ebW5fsWqsry0_o17gL4OZg&oe=6426AFC6';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // TODO: Show image picker dialog
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_profileImage),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tên',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _name,
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập tên của bạn',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Số điện thoại',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _phoneNumber,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập số điện thoại của bạn',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _email,
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập email của bạn',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Save changes
                  },
                  child: const Text('Lưu'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Discard changes
                  },
                  child: const Text('Hủy bỏ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
