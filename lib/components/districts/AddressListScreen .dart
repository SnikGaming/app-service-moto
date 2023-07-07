// ignore_for_file: file_names, library_prefixes, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../modules/home/api/address/api_address.dart';
import '../../modules/home/api/address/model.dart' as Address;
import '../../modules/home/api/location/api_location.dart';
import '../../modules/home/layouts/pages/services_page.dart';
import '../../network/api/otp.dart';
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
            // Last item, display the "Add Address" button
            return ListTile(
              title: const Text(txtAddAddress),
              leading: const Icon(Icons.add),
              onTap: () {
                // addressLocation(context: context).then((value) => loadData());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormInputLocation(
                              data: APILocation.dataLocation,
                            ))).then((value) => loadData());
                // dangGuiMail(context);
                // Implement add address functionality
              },
            );
          } else {
            final address = addresses[index];
            return ListTile(
              tileColor: const Color.fromRGBO(102, 21, 207, 0.571),
              title: Text(
                address.name!,
                style: h1.copyWith(
                  color: Colors.white,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.phoneNumber!,
                    style: h1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${address.address}, ${address.ward}, ${address.district}, ${address.province}',
                    style: h1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.yellowAccent),
                    onPressed: () {
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
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      APIAddress.deleteAddress(address.id!);
                      loadData();
                      // Implement delete address functionality
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context, address);
              },
            );
          }
        },
      ),
    );
  }
}
