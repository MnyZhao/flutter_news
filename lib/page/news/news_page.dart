import 'package:flutter/material.dart';
import 'package:flutter_news/localization/my_locations.dart';
import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/net/news_resository.dart';
import 'package:flutter_news/widgets/custom_tab.dart';
import 'package:flutter_news/widgets/news_item.dart';
import 'package:flutter_news/widgets/search.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  AnimationController animationController;
  AnimationController animationTraslateController;
  Animation<Offset> slideAnimation;
  List<String> list = new List<String>();
  MyLocation language;
  List<News> newsList = new List<News>();
  NewsResository resository;
  int selected = 0;
  int _page = 0;
  bool _isMore = false;
  bool _isLoadOver = false;
  bool _isEmpty = false; //默认不是空
  List<String> _categories = new List<String>();
  NewsResository _resository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initScrollerListener();
    initAnimation();
    initMsg();
  }

  @override
  Widget build(BuildContext context) {
    language = MyLocation.of(context);
    list.clear();
    list.add(language.trans("cat_geral"));
    list.add(language.trans("cat_esporte"));
    list.add(language.trans("cat_tecnologia"));
    list.add(language.trans("cat_entretenimento"));
    list.add(language.trans("cat_saude"));
    list.add(language.trans("cat_negocios"));
    return _getBody();
  }

  Widget _getBody() {
    return Stack(
      children: <Widget>[
        _getTranslateList(),
        _getProgressWidget(_isLoadOver),
        _getEmptyWidget(_isEmpty),
        _getCustomTab(),
      ],
    );
  }

  Widget _getTranslateList() {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: animationController,
        child: _getList(newsList),
      ),
    );
  }

  Widget _getList(List<News> list) {
    return ListView.builder(
      itemCount: list.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: EdgeInsets.only(top: 50.0),
            child: NewsItem(list[index]),
          );
        } else {
          return NewsItem(list[index]);
        }
      },
    );
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

  Widget _getCustomTab() {
    return CustomTab(
      tabSelected: (index) {
        //若选中不同的则清空集合并重新加载
        if (selected != index) {
          _isMore = false;
          selected = index;
          setState(() {
            newsList.clear();
            loadNews(_categories[selected]);
            _isLoadOver = false;
          });
        }
      },
      str: list,
    );
  }

  void loadNews(category) {
    if (_isMore) {
      _page++;
    } else {
      _page = 0;
    }
    _resository.loadNews(category, _page).then((listNews) {
      if (!_isMore) {
        animationController.forward(from: 0.0);
        animationTraslateController.forward(from: 0.0);
      }
      setState(() {
        _isEmpty = listNews.isEmpty;
        _isLoadOver = true;
        newsList.addAll(listNews);
      });
    }).catchError((onError) {
      _isEmpty = true;
      _isLoadOver = true;
    });
  }

  void initScrollerListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isMore = true;
        loadNews(_categories[selected]);
        setState(() {
          _isLoadOver = false;
        });
      }
    });
  }

  void initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    animationTraslateController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    slideAnimation = Tween(begin: Offset(0.0, 5.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
            parent: animationTraslateController, curve: Curves.decelerate));
  }

  void initMsg() {
    _resository = NewsResository(true);
    _categories.add("geral");
    _categories.add("sports");
    _categories.add("technology");
    _categories.add("entertainment");
    _categories.add("health");
    _categories.add("business");
    loadNews(_categories[selected]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
    animationTraslateController.dispose();
  }
}
