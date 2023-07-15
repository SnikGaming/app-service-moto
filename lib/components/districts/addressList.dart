// ignore_for_file: file_names, library_prefixes, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:app/components/style/text_style.dart';
import 'package:flutter/material.dart';
import '../../api/address/api_address.dart';
import '../../api/address/model.dart' as Address;
import '../../api/location/api_location.dart';
import '../value_app.dart';
import 'form_input_address.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List<Address.Data> addresses = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await APIAddress.fetchAddress();
    setState(() {
      addresses = APIAddress.lsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 129, 67, 230),
        title: const Text(txtAddressList),
      ),
      body: ListView.builder(
        itemCount: addresses.length + 1, // +1 for the "Add Address" button
        itemBuilder: (context, index) {
          if (index == addresses.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormInputLocation(
                                    data: APILocation.dataLocation,
                                  ))).then((value) => loadData());
                    },
                    child: Container(
                      height: 48,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Thêm địa chỉ',
                              style: title1.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            );
          } else {
            final address = addresses[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: const BoxConstraints(minHeight: 100),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 14, 135, 151),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context, address),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Người nhận : ',
                                  style: title1.copyWith(fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: address.name!,
                                        style: title1.copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Số điện thoại : ',
                                  style: title1.copyWith(fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: address.phoneNumber!,
                                        style: title1.copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Địa chỉ nhận : ',
                                  style: title1.copyWith(fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${address.address}, ${address.ward}, ${address.district}, ${address.province}',
                                        style: title1.copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              GestureDetector(
                                child: const Icon(Icons.edit,
                                    color: Colors.yellowAccent),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormInputLocation(
                                        data: APILocation.dataLocation,
                                        defaultProvinceId: address.idProvince!,
                                        defaultDistrictId: address.idDistrict!,
                                        defaultWardId: address.idWard!,
                                        defaultName: address.name!,
                                        defaultAddress: address.address!,
                                        defaultPhone: address.phoneNumber!,
                                        id: address.id,
                                      ),
                                    ),
                                  ).then((value) => loadData());
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  APIAddress.deleteAddress(address.id!);
                                  loadData();
                                  // Implement delete address functionality
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
