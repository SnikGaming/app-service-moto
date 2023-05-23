import 'package:app/components/districts/province.dart';
import 'package:app/components/message/message.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class LocationSelectionScreen extends StatefulWidget {
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
                  print('data test $selectedDistricts');
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
            TextButton(
              onPressed: () {
                if (selectedProvince != null &&
                    selectedDistrict != null &&
                    selectedCommune != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Selected Location'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Province: ${selectedProvince!.name}'),
                            Text('District: ${selectedDistrict!.name}'),
                            Text('Commune: ${selectedCommune!.name}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please select a province, district, and commune.'),
                    ),
                  );
                }
              },
              child: Text('ok'),
            ),
          ],
        ),
      ),
    );
  }
}
