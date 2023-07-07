// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, null_check_always_fails, unused_local_variable, unused_element

import 'dart:convert';

import 'package:app/components/button/mybutton.dart';
import 'package:app/components/message/message.dart';
import 'package:app/components/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/api/location/model.dart';

import '../../modules/home/api/address/api_address.dart';
import '../textformfield/customTextFormField.dart';
import '../validator/phone.dart';

class FormInputLocation extends StatefulWidget {
  final List<Data> data;
  final int defaultProvinceId;
  final int defaultDistrictId;
  final int defaultWardId;
  final String defaultPhone;
  final String defaultName;
  final String defaultAddress;
  final int? id;

  const FormInputLocation({
    Key? key,
    required this.data,
    this.defaultProvinceId = 0,
    this.defaultDistrictId = 0,
    this.defaultWardId = 0,
    this.defaultName = '',
    this.defaultAddress = '',
    this.defaultPhone = '',
    this.id,
  });

  @override
  _FormInputLocationState createState() => _FormInputLocationState();
}

class _FormInputLocationState extends State<FormInputLocation> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController phoneController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final _formKey = GlobalKey<FormState>();

  Data? selectedData;
  Districts? selectedDistrict;
  Wards? selectedWard;

  @override
  void initState() {
    super.initState();
    load();
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
    addressController.dispose();
    super.dispose();
  }

  void load() {
    if (widget.defaultName.isNotEmpty &&
        widget.defaultAddress.isNotEmpty &&
        widget.defaultPhone.isNotEmpty) {
      nameController.text = widget.defaultName;
      addressController.text = widget.defaultAddress;
      phoneController.text = widget.defaultPhone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tên người dùng không được để trống.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<Data>(
                      value: selectedData,
                      hint: const Text('Tỉnh/ Thành phố'),
                      onChanged: (Data? newValue) {
                        setState(() {
                          selectedData = newValue;
                          selectedDistrict = null;
                          selectedWard = null;
                        });
                      },
                      items:
                          widget.data.map<DropdownMenuItem<Data>>((Data data) {
                        return DropdownMenuItem<Data>(
                          value: data,
                          child: Text(data.name!),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<Districts>(
                      value: selectedDistrict,
                      hint: const Text('Quận/ Huyện'),
                      onChanged: (Districts? newValue) {
                        setState(() {
                          selectedDistrict = newValue;
                          selectedWard = null;
                        });
                      },
                      items: selectedData?.districts
                              ?.map<DropdownMenuItem<Districts>>(
                                  (Districts district) {
                            return DropdownMenuItem<Districts>(
                              value: district,
                              child: Text(district.name!),
                            );
                          }).toList() ??
                          [],
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<Wards>(
                      value: selectedWard,
                      hint: const Text('Phường/ Xã'),
                      onChanged: (Wards? newValue) {
                        setState(() {
                          selectedWard = newValue;
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Số nhà/tên đường không được để trống.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              MyButton(
                onPressed: _handleSubmit,
                backgroundColor: Colors.red,
                child: Text(
                  'Lưu',
                  style: h2.copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * .6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedData == null ||
        selectedDistrict == null ||
        selectedWard == null) {
      Message.error(
          message: 'Vui lòng chọn đầy đủ thông tin', context: context);
      return;
    }

    final idProvince = selectedData!.provinceId;
    final idDistrict = selectedDistrict!.districtId;
    final idWard = selectedWard!.wardsId;
    final name = nameController.text;
    final phone = phoneController.text;
    final address = addressController.text;

    if (name.isEmpty || phone.isEmpty || address.isEmpty) {
      Message.error(
          message: 'Vui lòng điền đầy đủ thông tin', context: context);
      return;
    }

    final jsonData = {
      'idProvince': idProvince,
      'idDistrict': idDistrict,
      'idWard': idWard,
      'name': name,
      'phone_number': phone,
      "address": address
    };

    final jsonString = json.encode(jsonData);
    if (widget.id == null) {
      var res = await APIAddress.addAddress(jsonData);
      if (res.statusCode == 200) {
        Message.success(message: 'Thêm thành công', context: context);
        Navigator.pop(context);
      } else {
        Message.error(message: 'Thêm thất bại', context: context);
      }
    } else {
      var res = await APIAddress.updateAddress(jsonData, widget.id!);
      if (res.statusCode == 200) {
        Message.success(message: 'Cập nhật thành công', context: context);
        Navigator.pop(context);
      } else {
        Message.error(message: 'Cập nhật thất bại', context: context);
      }
    }
  }
}
