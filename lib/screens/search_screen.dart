import 'package:flutter/material.dart';
import 'package:news_app/widgets/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  bool isSearching = false;
  String query = "";
  String tag = "";
  @override
  void initState() {
    textController.addListener(() {
      query = textController.text;
      setState(() {
        if (textController.text.isEmpty) {
          isSearching = false;
        } else {
          isSearching = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64,
          color: Colors.amber,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: CustomTextField(
            controller: textController,
          ),
        ),
        Expanded(
            child: isSearching
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 == 0 ? Colors.teal : Colors.blue,
                        height: 128,
                      );
                    },
                  )
                : Wrap(children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                    )
                  ]))
      ],
    );
  }
}
