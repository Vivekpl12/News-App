import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app1/models/article.dart';

class NewsApi {
  static const _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=a9a4a9ba40bf4494aa2b7fe300c499d5';

  Future<List<Article>> fetchTopHeadlines() async {
    final url = Uri.parse(_baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List articlesJson = jsonBody['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
