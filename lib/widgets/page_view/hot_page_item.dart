import 'package:flutter/material.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/page/detail/detailes.dart';
import 'package:flutter_news/util/funcations.dart';
import 'package:flutter_news/widgets/page_view/page_transformer.dart';

class HotItem extends StatefulWidget {
  News news;
  PageVisibility pageVisibility;

  HotItem({this.news, this.pageVisibility});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotItemState();
  }
}

class HotItemState extends State<HotItem> {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    return _getBody();
  }

  Widget _getBody() {
    return GestureDetector(
      onTap: () {
        Navigator.of(_context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return DetailesPage(widget.news);
        }));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          elevation: 3,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: widget.news.title,
                child: _getImageNet(
                    Functions.getImgResizeUrl(widget.news.img, 200, '')),
              ),
              _getGradient(),
              _getText(_context),
            ],
          ),
        ),
      ),
    );
  }

  /**
   * 渐变色
   */
  Widget _getGradient() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        )),
      ),
    );
  }

  /**
   * 获取网络图片
   */
  Widget _getImageNet(url) {
    try {
      if (url != '') {
        return ClipRRect(
          borderRadius: new BorderRadius.circular(8.0),
          child: new FadeInImage.assetNetwork(
            placeholder: 'assets/place_holder.jpg',
            image: url,
            fit: BoxFit.cover,
            alignment: new FractionalOffset(
              0.5 + (widget.pageVisibility.pagePosition / 3),
              0.5,
            ),
          ),
        );
      } else {
        return ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/place_holder_2.jpg',
              fit: BoxFit.cover,
            ));
      }
    } catch (e) {
      return ClipRRect(
          borderRadius: new BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/place_holder_2.jpg',
            fit: BoxFit.cover,
          ));
    }
  }

  Widget _getText(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Positioned(
        bottom: 56.0,
        left: 32.0,
        right: 32.0,
        child: Column(
          children: <Widget>[
            _getTransWidget(
              translationFactor: 300,
              child: Text(
                widget.news.category,
                textAlign: TextAlign.center,
                style: textTheme.caption.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontSize: 14.0,
                ),
              ),
            ),
            _getTransWidget(
                translationFactor: 300,
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(widget.news.title,
                      textAlign: TextAlign.center,
                      style: textTheme.caption.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )),
          ],
        ));
  }

  Widget _getTransWidget(
      {@required double translationFactor, @required Widget child}) {
   //随着页面展示移动的像素 通过matrix计算的不是
    final double xTranslation =
        widget.pageVisibility.pagePosition * translationFactor;
    print("position" + widget.pageVisibility.pagePosition.toString());
    return Opacity(
      opacity: widget.pageVisibility.visibleFraction, //透明度的变化
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(xTranslation, 0.0, 0.0),
        child: child,
      ),
      /* */
    );
  }
}
