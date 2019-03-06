import 'package:flutter/material.dart';
import 'package:flutter_news/localization/my_locations.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/net/news_resository.dart';
import 'package:flutter_news/widgets/hot_page_item.dart';

class HotSportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotSportPageState();
  }
}

class HotSportPageState extends State<HotSportPage> {
  NewsResository resository;
  List<News> listNews = new List<News>();
  bool isLoadOver = false;
  bool isEmpty = false;
  MyLocation language;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resository = NewsResository(true);
    resository.loadRect().then((listValue) {
      setState(() {
        isLoadOver = true;
        listNews.addAll(listValue);
        isEmpty = listNews.isEmpty;
      });
    }).catchError((onError) {
      isLoadOver = true;
      isEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    language = MyLocation.of(context);
    // TODO: implement build
    return Stack(
      children: <Widget>[
        RefreshIndicator(
            child: _getPageview(listNews),
            onRefresh: () {
              print('Refresh current');
              resository.loadRect().then((list) {
                setState(() {
                  isLoadOver = true;
                  listNews = list;
                });
              }).catchError((error) {
                isLoadOver = true;
              });
            }),
//        _getPageview(listNews),
        _getProgressWidget(isLoadOver),
        _getEmptyWidget(isEmpty),
      ],
    );
  }

  Widget _getPageview(List<News> list) {
    return PageView.builder(
        itemCount: list.length,
        controller: PageController(viewportFraction: 0.8),
        itemBuilder: (context, index) {
          return HotItem(list[index]);
        });
  }

  /**
   * 获取progress
   */
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
}
