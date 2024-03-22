import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/theme.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            boxShadow: AppThemeData.getShadow(),
            color: darkTheme
                ? Colors.black.withOpacity(0.9)
                : Colors.grey.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: const Icon(
          Icons.arrow_back_ios_new,
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final Function() onTap;
  final bool isSaved;
  const SaveButton({super.key, required this.onTap, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            boxShadow: AppThemeData.getShadow(),
            color: darkTheme ? const Color(0xff1c1c1c) : Colors.white,
            shape: BoxShape.circle),
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
        ),
      ),
    );
  }
}

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  const ForwardButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            boxShadow: AppThemeData.getShadow(),
            color: darkTheme ? const Color(0xff1c1c1c) : Colors.white,
            shape: BoxShape.circle),
        child: const Icon(
          Icons.share_outlined,
        ),
      ),
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  final Function() onTap;
  const ReadMoreButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            boxShadow: AppThemeData.getShadow(),
            color: darkTheme ? Colors.black : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.readMore,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
  }
}

class DeleteTagsButton extends StatelessWidget {
  final Function() onTap;
  const DeleteTagsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            boxShadow: AppThemeData.getShadow(),
            color: darkTheme ? const Color(0xff1c1c1c) : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Row(
          children: [
            Icon(
              Icons.cancel_rounded,
              color: darkTheme ? Colors.white : Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
