import 'package:flutter/material.dart';
import 'package:news_app/widgets/custom_textfield.dart';
import 'package:news_app/widgets/header.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: "Your Collection"),
        Container(
          height: 64,
          color: Colors.amber,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: CustomTextField(
            controller: textController,
          ),
        ),
        Expanded(child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              color: index % 2 == 0 ? Colors.teal : Colors.blue,
              height: 128,
            );
          },
        ))
      ],
    );
  }
}
