import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final onSubmit;
  const CustomTextField(
      {super.key, required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
      decoration: BoxDecoration(
        color: darkTheme ? const Color(0xff1c1c1c) : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: AppThemeData.getShadow(),
      ),
      child: TextField(
        maxLines: 1,
        onSubmitted: onSubmit,
        controller: controller,
        decoration: InputDecoration(
            hintText: t.hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            suffixIcon: const Icon(Icons.search),
            border: InputBorder.none),
      ),
    );
  }
}
