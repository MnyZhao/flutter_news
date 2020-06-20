import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_news/localization/locations_delegate.dart';
import 'package:flutter_news/page/home/home_page.dart';
import 'package:flutter_news/widgets/bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyLocationDelegate myLocation = const MyLocationDelegate();

  @override
  Widget build(BuildContext context) {
    print('日志');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter News',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
      ),
      //多语言配置
      supportedLocales: MyLocationDelegate.supportedLocales(),
      // 配置代理类
      localizationsDelegates: [
        myLocation,// 我们自己的翻译 比如要显示的文本等
        DefaultCupertinoLocalizations.delegate,//Cupertino widgets.的英语翻译
        GlobalMaterialLocalizations.delegate,//Material widgets.的英语翻译
        GlobalWidgetsLocalizations.delegate,// 本地化Widget 的翻译
      ],
      //通过localeResolutionCallback或localeListResolutionCallback回调来监听locale改变的事件
      localeResolutionCallback: myLocation.resolution,
      home: HomePage(),

    );
  }
}
