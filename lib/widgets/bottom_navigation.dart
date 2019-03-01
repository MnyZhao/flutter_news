import 'package:flutter/material.dart';
import 'package:flutter_news/localization/MyLocalizations.dart';

class BottomNavigation extends StatefulWidget {
  final callback;

  BottomNavigation(this.callback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomNavigationState();
  }
}

class BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;
  MyLocalizations mLanguage;

  @override
  Widget build(BuildContext context) {
    mLanguage = MyLocalizations.of(context);
    // TODO: implement build
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.language),
            title: Text(mLanguage.trans("tab_recentes"))),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
            title: Text(mLanguage.trans("tab_noticias"))),
        BottomNavigationBarItem(
            icon: Icon(Icons.info), title: Text(mLanguage.trans("tab_sobre"))),
      ],
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          print("index:" + index.toString());
          _index = index;
          widget.callback(index);
        });
      },
    );
  }
}
