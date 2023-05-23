// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String hintText;
  final Function(String) onSearch;

  const MySearchBar({
    Key? key,
    required this.hintText,
    required this.onSearch,
  }) : super(key: key);

  @override
  _MySearchBarState createState() => _MySearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MySearchBarState extends State<MySearchBar> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (value) {
                  widget.onSearch(value);
                },
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                _textEditingController.clear();
                widget.onSearch('');
              },
            ),
          ],
        ),
      ),
    );
  }
}
