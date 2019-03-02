import 'package:flutter/material.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/page/detail/detailes.dart';
import 'package:flutter_news/util/DateUtil.dart';
import 'package:flutter_news/util/funcations.dart';

class NewsItem extends StatelessWidget {
  News news;

  NewsItem(this.news);

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    return _getNewsItem();
  }

  Widget _getNewsItem() {
    return GestureDetector(
      onTap: () {
        Navigator.of(_context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return new DetailesPage(news);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
        child: Material(
          borderRadius: BorderRadius.circular(6.0),
          elevation: 2.0,
          child: _getListTile(),
        ),
      ),
    );
  }

  Widget _getListTile() {
    return Container(
      height: 95.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: news.title,
            child: _getImageWidget(news.img),
          ),
          _getTextColumn(),
        ],
      ),
    );
  }

  Widget _getImageWidget(String url) {
    return Container(
      width: 95.0,
      height: 95.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0), bottomLeft: Radius.circular(6.0)),
        child: _getImageNetWork(url),
      ),
    );
  }

  /**
   * 获取网络头像
   */
  Widget _getImageNetWork(String url) {
    try {
      if (url.isNotEmpty) {
        return new FadeInImage.assetNetwork(
          placeholder: 'assets/place_holder.jpg',
          image: url,
          fit: BoxFit.cover,
        );
      } else {
        return new Image.asset('assets/place_holder.jpg');
      }
    } catch (e) {
      return new Image.asset('assets/place_holder.jpg');
    }
  }

  Text _getTitleWidget(String currentName) {
    return Text(
      currentName,
      maxLines: 1,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescriptionWidget(String description) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Text(
        description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Text _getDateWidget(String date) {
    return new Text(
      new DateUtil().buildDate(date),
      style: new TextStyle(color: Colors.grey, fontSize: 10.0),
    );
  }

  Widget _getTextColumn() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitleWidget(news.title),
          _getDateWidget(news.date),
          _getDescriptionWidget(news.description)
        ],
      ),
    ));
  }
}
