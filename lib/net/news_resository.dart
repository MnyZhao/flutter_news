import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/net/api.dart';

class NewsResository {
  final _api = Api("http://104.131.18.84");
  final bool _prod;

  NewsResository(this._prod);

  /**
   * 加载新闻
   */
  Future<List<News>> loadNews(String category, int page) async {
    return _prod ? _serverNews(category, page) : _LoadNews();
  }

  /**
   * 加载搜索
   */
  Future<List<News>> loadSearch(String query) async {
    return _prod ? _serverSearch(query) : _localSearch();
  }

  Future<List<News>> _serverNews(String category, int page) async {
    final Map result = await _api.get("/notice/news/$category/$page");
    return result['data']['news']
        .map<News>((notice) => new News.fromJson(notice))
        .toList();
  }

  Future<List<News>> _serverSearch(String query) async {
    final Map result = await _api.get("/notice/search/$query");

    if (result['op']) {
      return result['data']
          .map<News>((notice) => new News.fromJson(notice))
          .toList();
    } else {
      return List();
    }
  }

  _localSearch() {
    return new List();
  }

  _LoadNews() {
    return new List();
  }
}
