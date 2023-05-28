import 'package:flutter/material.dart';
import '../../modules/home/api/address/api_address.dart';
import '../../modules/home/api/address/model.dart' as Address;
import '../../modules/home/api/location/api_location.dart';
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
              title: Text(address.name!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.phoneNumber!),
                  Text(
                      '${address.address}, ${address.ward}, ${address.district}, ${address.province}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
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
                    icon: const Icon(Icons.delete),
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
