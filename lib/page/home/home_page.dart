import 'package:flutter/material.dart';
import 'package:flutter_news/page/about/about_page.dart';
import 'package:flutter_news/widgets/bottom_navigation.dart';
import 'package:flutter_news/widgets/search.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Widget> list = [
    page('1'),
    page('2'),
    Info(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Search(),
            ),
            Expanded(
              child: list[_index],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation((index) {
        setState(() {
          _index = index;
        });
      }),
    );
  }
}

class page extends StatelessWidget {
  String msg;

  page(this.msg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Text(msg),
      ),
    );
  }
}
