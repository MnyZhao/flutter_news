import 'package:flutter/material.dart';
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
    print("initState");
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {

  List<News> list = new List();
  static bool prod=true;
  NewsResository resository=NewsResository(prod);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resository.loadSearch(widget.query).then((listValue){
      debugPrint(listValue.length.toString()+"");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.query),
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(top: 8.0),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return NewsItem(list[index]);
          }),
    );
  }
}
