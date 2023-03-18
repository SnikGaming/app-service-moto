import 'package:flutter/material.dart';

class SearchCustom extends SearchDelegate {
  List<String> allData = [
    "Doreamon",
    "Nobita",
    "Chai en",
    "Xeko",
    "Doreame",
    "Xuka",
  ];

  List<String> mathQuery = [];

  // @override
  // void set query(String value) {
  //   super.query = value;
  //   mathQuery = allData.where((item) => item.toLowerCase().contains(value.toLowerCase())).toList();
  //   // update the mathQuery list whenever the user types something in the search field
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        mathQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: mathQuery.length,
      itemBuilder: (context, index) {
        var result = mathQuery[index];

        return ListTile(
          title: Text(result),
          onTap: () {
            query =
                result; // update the search field with the selected suggestion
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        mathQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: mathQuery.length,
      itemBuilder: (context, index) {
        var result = mathQuery[index];

        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
