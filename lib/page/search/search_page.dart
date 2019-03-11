import 'package:flutter/material.dart';
import 'package:flutter_news/localization/my_locations.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/net/news_resository.dart';
import 'package:flutter_news/widgets/news_item.dart';

class SearchPage extends StatefulWidget {
  final String query;

  SearchPage(this.query);

  static Widget create(String query) {
    return SearchPage(query);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<News> list = new List();
  static bool prod = true;
  NewsResository resository = NewsResository(prod);
  MyLocation language;
  bool isLoadOver = false;
  bool isEmpty = false; //默认不是空
  AnimationController animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    _animation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);
    resository.loadSearch(widget.query).then((listValue) {
      setState(() {
        isEmpty = listValue.isEmpty;
        isLoadOver = true;
        list.addAll(listValue);
        animationController.forward();
      });
    }).catchError((onError){
      isEmpty = true;
      isLoadOver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    language = MyLocation.of(context);
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.query),
        ),
        body: Stack(
          children: <Widget>[
            FadeTransition(
              opacity: _animation,
              child: _getListWidget(list),
            ),
            _getProgressWidget(isLoadOver),
            _getEmptyWidget(isEmpty),
          ],
        ));
  }

  ListView _getListWidget(List<News> list) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 8.0),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return NewsItem(list[index]);
        });
  }

  Widget _getProgressWidget(bool isLoadOver) {
    return isLoadOver
        ? Container()
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget _getEmptyWidget(bool isEmpty) {
    return isEmpty
        ? Container(
            child: Center(
              child: Text(language.trans("erro_busca")),
            ),
          )
        : Container();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
}
