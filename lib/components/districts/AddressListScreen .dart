// ignore_for_file: file_names, library_prefixes, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../modules/home/api/address/api_address.dart';
import '../../modules/home/api/address/model.dart' as Address;
import '../../modules/home/api/location/api_location.dart';
import '../../modules/home/layouts/pages/services_page.dart';
import 'location_db.dart';

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
        title: const Text('Address List'),
      ),
      body: ListView.builder(
        itemCount: addresses.length + 1, // +1 for the "Add Address" button
        itemBuilder: (context, index) {
          if (index == addresses.length) {
            // Last item, display the "Add Address" button
            return ListTile(
              title: const Text('Add Address'),
              leading: const Icon(Icons.add),
              onTap: () {
                addressLocation(context: context).then((value) => loadData());
                // Implement add address functionality
              },
            );
          } else {
            final address = addresses[index];
            return ListTile(
              tileColor: Color.fromRGBO(61, 54, 54, 0.473),
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
                      addressLocation(
                          context: context,
                          defaultProvinceId: address.idProvince,
                          defaultDistrictId: address.idDistrict,
                          name: address.name,
                          phone: address.phoneNumber,
                          address: address.address,
                          id: address.id,
                          defaultWardId: address.idWard);
                      loadData();
                      // Implement edit address functionality
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

  Future<dynamic> addressLocation(
      {required BuildContext context,
      String? phone,
      String? address,
      String? name,
      int? defaultProvinceId,
      int? defaultDistrictId,
      int? defaultWardId,
      int? id}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Expanded(
            child: defaultProvinceId != null &&
                    defaultDistrictId != null &&
                    defaultWardId != null &&
                    phone != null &&
                    name != null &&
                    address != null &&
                    id != null
                ? LocationDropdown(
                    data: APILocation.dataLocation,
                    defaultProvinceId: defaultProvinceId,
                    defaultDistrictId: defaultDistrictId,
                    defaultWardId: defaultWardId,
                    defaultName: name,
                    defaultAddress: address,
                    defaultPhone: phone,
                    id: id,
                  )
                : LocationDropdown(
                    data: APILocation.dataLocation,
                  ),
          ),
        );
      },
    );
  }
}
