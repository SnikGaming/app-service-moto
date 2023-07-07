import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import '../../api/products/models/products.dart' as products;
import '../../../network/connect.dart';
import '../../../api/products/models/products.dart';

class MySearchDelegate extends SearchDelegate {
  final List<Data> items;

  MySearchDelegate({required this.items});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Data> result = items
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: '${ConnectDb.url}${result[index].image}',
              // height: 30,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(result[index].name!),
            onTap: () {
              close(context, result[index]);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Data> suggestionList = query.isEmpty
        ? []
        : items
            .where((item) =>
                item.image!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: '${ConnectDb.url}${suggestionList[index].image}',
            height: 30,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(suggestionList[index].name!),
          onTap: () {
            query = suggestionList[index].name!;
            showResults(context);
          },
        );
      },
    );
  }
}
