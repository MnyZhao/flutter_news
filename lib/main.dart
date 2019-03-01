import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_news/localization/MyLocalizationsDelegate.dart';
import 'package:flutter_news/page/home/home_page.dart';
import 'package:flutter_news/widgets/bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  @override
  Widget build(BuildContext context) {
    print('日志');
    return MaterialApp(
      title: 'Flutter News',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
      ),
      //多语言配置
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
      home: HomePage(),

    );
  }
}
