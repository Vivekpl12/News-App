import '../models/article.dart';
import '../services/news_api.dart';
class NewsRepository {
  final NewsApi _api;
  NewsRepository(this._api);
  Future<List<Article>> getTopHeadlines()async{
    try{
      return await _api.fetchTopHeadlines();
    }catch(e){
      throw Exception('Repository failed:$e');
    }
  }
}