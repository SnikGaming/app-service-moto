// ignore_for_file: null_check_always_fails

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/modules/home/api/location/model.dart';

import '../textformfield/customTextFormField.dart';
import '../validator/phone.dart';

class LocationDropdown extends StatefulWidget {
  final List<Data> data;
  final int defaultProvinceId;
  final int defaultDistrictId;
  final int defaultWardId;

  LocationDropdown({
    required this.data,
    this.defaultProvinceId = 0,
    this.defaultDistrictId = 0,
    this.defaultWardId = 0,
  });

  @override
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  Data? selectedData;
  Districts? selectedDistrict;
  Wards? selectedWard;
  String selectedProvinceName = '';
  String selectedProvinceId = '';
  String selectedDistrictName = '';
  String selectedDistrictId = '';
  String selectedWardName = '';
  String selectedWardId = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set default values based on the provided IDs
    if (widget.defaultProvinceId != 0) {
      selectedData = widget.data.firstWhere(
        (data) => data.provinceId == widget.defaultProvinceId,
        orElse: () => null!,
      );
    }
    if (widget.defaultDistrictId != 0 && selectedData != null) {
      selectedDistrict = selectedData!.districts?.firstWhere(
        (district) => district.districtId == widget.defaultDistrictId,
        orElse: () => null!,
      );
    }
    if (widget.defaultWardId != 0 && selectedDistrict != null) {
      selectedWard = selectedDistrict!.wards?.firstWhere(
        (ward) => ward.wardsId == widget.defaultWardId,
        orElse: () => null!,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    noteController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            CustomTextField(
              controller: phoneController,
              textInputAction: TextInputAction.next,
              hintText: 'Nhập số điện thoại',
              keyboardType: TextInputType.phone,
              validator: validatePhoneNumber,
            ),

            const SizedBox(height: 16),
            CustomTextField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              hintText: 'Tên người nhận hàng',
            ),
            const SizedBox(height: 16),
            // Data Dropdown
            DropdownButton<Data>(
              value: selectedData,
              hint: const Text('Select Data'),
              onChanged: (Data? newValue) {
                setState(() {
                  selectedData = newValue;
                  selectedDistrict = null;
                  selectedWard = null;
                  selectedProvinceName = '';
                  selectedProvinceId = '';
                  selectedDistrictName = '';
                  selectedDistrictId = '';
                  selectedWardName = '';
                  selectedWardId = '';
                });
              },
              items: widget.data.map<DropdownMenuItem<Data>>((Data data) {
                return DropdownMenuItem<Data>(
                  value: data,
                  child: Text(data.name!),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // District Dropdown
            DropdownButton<Districts>(
              value: selectedDistrict,
              hint: const Text('Select District'),
              onChanged: (Districts? newValue) {
                setState(() {
                  selectedDistrict = newValue;
                  selectedWard = null;
                  selectedDistrictName = '';
                  selectedDistrictId = '';
                  selectedWardName = '';
                  selectedWardId = '';
                });
              },
              items: selectedData?.districts
                      ?.map<DropdownMenuItem<Districts>>((Districts district) {
                    return DropdownMenuItem<Districts>(
                      value: district,
                      child: Text(district.name!),
                    );
                  }).toList() ??
                  [],
            ),
            const SizedBox(height: 16),
            // Ward Dropdown
            DropdownButton<Wards>(
              value: selectedWard,
              hint: const Text('Select Ward'),
              onChanged: (Wards? newValue) {
                setState(() {
                  selectedWard = newValue;
                  selectedWardName = '';
                  selectedWardId = '';
                });
              },
              items: selectedDistrict?.wards
                      ?.map<DropdownMenuItem<Wards>>((Wards ward) {
                    return DropdownMenuItem<Wards>(
                      value: ward,
                      child: Text(ward.name!),
                    );
                  }).toList() ??
                  [],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: addressController,
              textInputAction: TextInputAction.next,
              hintText: 'Số nhà/Tên đường',
            ),
            const SizedBox(height: 16),

            // Note TextField
            CustomTextField(
              controller: noteController,
              textInputAction: TextInputAction.next,
              hintText: 'Note',
            ),
            const SizedBox(height: 16),
            // Submit Button
            TextButton(
              onPressed: _handleSubmit,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16),
            // Selected Info
            _buildSelectedInfo(),
            Padding(
                padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * .6,
            ))
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    setState(() {
      selectedProvinceName = selectedData?.name ?? '';
      selectedProvinceId = selectedData?.provinceId.toString() ?? '';
      selectedDistrictName = selectedDistrict?.name ?? '';
      selectedDistrictId = selectedDistrict?.districtId.toString() ?? '';
      selectedWardName = selectedWard?.name ?? '';
      selectedWardId = selectedWard?.wardsId.toString() ?? '';
    });

    final idProvince = selectedData?.provinceId ?? 0;
    final idDistrict = selectedDistrict?.districtId ?? 0;
    final idWard = selectedWard?.wardsId ?? 0;
    final name = nameController.text;
    final phone = phoneController.text;
    final note = noteController.text;
    final address = addressController.text;

    final jsonData = {
      'idProvince': idProvince,
      'idDistrict': idDistrict,
      'idWard': idWard,
      'name': name,
      'phone': phone,
      'note': note,
      "address": address
    };

    final jsonString = json.encode(jsonData);
    print('location data $jsonString');
  }

  Widget _buildSelectedInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Province: $selectedProvinceName'),
        Text('Province ID: $selectedProvinceId'),
        Text('Selected District: $selectedDistrictName'),
        Text('District ID: $selectedDistrictId'),
        Text('Selected Ward: $selectedWardName'),
        Text('Ward ID: $selectedWardId'),
      ],
    );
  }
}
