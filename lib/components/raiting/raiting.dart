import 'package:app/components/style/textstyle.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final double rating;
  final int count;
  final List<String> reviews;

  const RatingWidget({
    Key? key,
    required this.rating,
    required this.count,
    required this.reviews,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  List<bool> _isOpenList = [];
  List<List<String>> _replyList = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isOpenList = List.filled(widget.reviews.length, false);
    _replyList = List.generate(widget.reviews.length, (_) => []);
  }

  void _toggleExpand(int index) {
    setState(() {
      _isOpenList[index] = !_isOpenList[index];
    });
  }

  void _addReply(int index, String reply) {
    setState(() {
      if (_controller.text.isNotEmpty) _replyList[index].add(reply);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 30,
              ),
              const SizedBox(width: 4),
              Text(widget.rating.toStringAsFixed(1),
                  style: MyTextStyle.title
                      .copyWith(color: Colors.grey, fontSize: 20)),
              const SizedBox(width: 8),
              Text('(${widget.count} đánh giá)',
                  style: MyTextStyle.title
                      .copyWith(color: Colors.grey, fontSize: 20)),
            ],
          ),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.reviews.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text('Đánh giá ${index + 1}'),
                            trailing: IconButton(
                              icon: Icon(
                                _isOpenList[index]
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              ),
                              onPressed: () => _toggleExpand(index),
                            ),
                          ),
                          if (_isOpenList[index])
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(widget.reviews[index]),
                            ),
                          if (_replyList[index].isNotEmpty == true &&
                              _isOpenList[index])
                            ..._replyList[index].map((reply) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    reply,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )),
                          if (_isOpenList[index])
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 255,
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 00.0, 0.0, 0.0),
                                        hintText: 'Trả lời đánh giá',
                                        border: OutlineInputBorder(),
                                      ),
                                      onFieldSubmitted: (value) =>
                                          _addReply(index, 'You: $value'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 26.0),
                                    child: IconButton(
                                      alignment: Alignment.topRight,
                                      icon: const Icon(
                                        Icons.send,
                                        size: 40,
                                      ),
                                      onPressed: () => _addReply(
                                          index, 'You: ${_controller.text}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
