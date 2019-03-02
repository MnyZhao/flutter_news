import 'package:flutter/material.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/util/DateUtil.dart';
import 'package:flutter_news/util/funcations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class DetailesPage extends StatelessWidget {
  News news;

  DetailesPage(this.news);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                shareNotice(news.title, news.link);
              })
        ],
        title: Text(news.title),
      ),
      body: _getDetail(news),
    );
  }

  Future shareNotice(_title, _link) async {
    await Share.share("$_title:\n$_link");
  }

  Widget _getDetail(News news) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(6.0),
        child: ListView(
          children: <Widget>[
            Hero(
              tag: news.title,
              child: _getHeaderImage(
                Functions.getImgResizeUrl(news.img, 200, ""),
              ),
            ),
            _getColumnText(news),
          ],
        ),
      ),
    );
  }

  _getHeaderImage(String url) {
    if (url != "") {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
        child: Container(
            height: 200.0,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/place_holder.jpg',
              image: url,
              fit: BoxFit.cover,
            )),
      );
    } else {
      return Container(
        height: 200.0,
        child: Image.asset('assets/place_holder_3.jpg'),
      );
    }
  }

  Widget _getColumnText(News news) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitle(news.title),
          _getDate(news.date, news.origin),
          _getDesc(news.description),
          _getAntLink(),
          _getLink(news.link),
        ],
      ),
    );
  }

  Widget _getAntLink() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Text(
        "Mais detalheas acesse:",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
      ),
    );
  }

  Widget _getLink(link) {
    return new GestureDetector(
      child: Text(
        link,
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        _launchURL(link);
      },
    );
  }

  Widget _getTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0));
  }

  Widget _getDate(date, origin) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            DateUtil().buildDate(date),
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          ),
          Text(
            origin,
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _getDesc(des) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(des),
    );
  }

  _launchURL(url) async {
    await launch(url);
  }
}
