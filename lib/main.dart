import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Flutter Demo',
        theme: AppThemeData.get(),
        home: const HomeScreen());
  }
}

String getLorem() {
  return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Commodo elit at imperdiet dui accumsan sit amet nulla. Elementum tempus egestas sed sed risus. Eu lobortis elementum nibh tellus. Et netus et malesuada fames ac. Purus viverra accumsan in nisl nisi scelerisque eu ultrices. Volutpat ac tincidunt vitae semper quis lectus nulla at. Tellus orci ac auctor augue. In nibh mauris cursus mattis molestie a iaculis at. Praesent semper feugiat nibh sed pulvinar. Risus sed vulputate odio ut enim blandit volutpat maecenas volutpat. In tellus integer feugiat scelerisque. Molestie ac feugiat sed lectus vestibulum mattis. Scelerisque in dictum non consectetur a erat nam. Porttitor eget dolor morbi non arcu. Volutpat consequat mauris nunc congue nisi. Nullam ac tortor vitae purus faucibus ornare suspendisse. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh. Sit amet aliquam id diam maecenas ultricies mi. In ante metus dictum at tempor commodo ullamcorper.";
}
