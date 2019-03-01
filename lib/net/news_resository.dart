import 'package:flutter_news/model/news/news.dart';
import 'package:flutter_news/net/api.dart';

class NewsResository {
  final _api = Api("http://104.131.18.84");
  final bool _prod;

  NewsResository(this._prod);


  Future<List<News>> loadSearch(String query) async {
    return _prod ? _serverSearch(query) : _localSearch();
  }
  Future<List<News>> _serverSearch(String query) async{

    final Map result = await _api.get("/notice/search/$query");

    if(result['op']){
      return result['data'].map<News>( (notice) => new News.fromJson(notice)).toList();
    }else{
      return List();
    }
  }
  _localSearch() {
    return new List();
  }
}