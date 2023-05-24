// ignore_for_file: library_private_types_in_public_api

import 'package:app/components/districts/province.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  List<Province> selectedProvinces = [];
  int index = 0;
  List<District> selectedDistricts = [];
  List<Commune> selectedCommunes = [];

  Province? selectedProvince;
  District? selectedDistrict;
  Commune? selectedCommune;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // phoneNumberController.text = UserPrefer.
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    houseNumberController.dispose();
    streetController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tỉnh/Thành phố',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<Province>(
              isExpanded: true,
              value: selectedProvince,
              hint: const Text('Chọn tỉnh/thành phố'),
              onChanged: (Province? value) {
                setState(() {
                  selectedProvince = value!;
                  selectedDistrict = null;
                  selectedCommune = null;
                  selectedDistricts = value.districts;
                  selectedCommunes = [];
                });
              },
              items: vietnamProvinces.map((province) {
                return DropdownMenuItem<Province>(
                  value: province,
                  child: Text(province.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Quận/Huyện',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<District>(
              isExpanded: true,
              value: selectedDistrict,
              hint: const Text('Chọn quận/huyện'),
              onChanged: (District? value) {
                setState(() {
                  selectedDistrict = value!;
                  selectedCommune = null;
                  selectedCommunes = value.communes;
                });
              },
              items: selectedDistricts.map((district) {
                return DropdownMenuItem<District>(
                  value: district,
                  child: Text(district.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Phường/Xã',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<Commune>(
              isExpanded: true,
              value: selectedCommune,
              hint: const Text('Chọn phường/xã'),
              onChanged: (Commune? value) {
                setState(() {
                  selectedCommune = value!;
                });
              },
              items: selectedCommunes.map((commune) {
                return DropdownMenuItem<Commune>(
                  value: commune,
                  child: Text(commune.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Số điện thoại',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Nhập số điện thoại',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Số nhà/đường',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: houseNumberController,
              decoration: const InputDecoration(
                hintText: 'Nhập số nhà/đường',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ghi chú',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Nhập ghi chú',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (selectedProvince != null &&
                    selectedDistrict != null &&
                    selectedCommune != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Selected Location'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Province: ${selectedProvince!.name}'),
                            Text('District: ${selectedDistrict!.name}'),
                            Text('Commune: ${selectedCommune!.name}'),
                            Text('Phone Number: ${phoneNumberController.text}'),
                            Text(
                                'House Number/Street: ${houseNumberController.text}'),
                            Text('Note: ${noteController.text}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please select a province, district, and commune.'),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
