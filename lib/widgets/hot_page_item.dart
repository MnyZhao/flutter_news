import 'package:flutter/material.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/util/funcations.dart';

class HotItem extends StatefulWidget {
  News news;

  HotItem(this.news);

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
    return Padding(
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
                  Functions.getImgResizeUrl(widget.news.img, 400, '')),
            ),
            _getGradient(),
            _getText(_context),
          ],
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
            /* alignment: new FractionalOffset(
              0.5 + (pageVisibility.pagePosition / 3),
              0.5,
            ),*/
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
            Text(
              widget.news.category,
              textAlign: TextAlign.center,
              style: textTheme.caption.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(widget.news.description,
                  textAlign: TextAlign.center,
                  style: textTheme.caption.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )
          ],
        ));
  }
}
