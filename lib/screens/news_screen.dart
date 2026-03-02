import 'package:flutter/material.dart';
import '../models/article.dart';
import '../repository/news_repositiry.dart';
import '../services/news_api.dart';
import '../widgets/article_tile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> _futureNews;
  final _respository = NewsRepository(NewsApi());
  @override
  void initState() {
    super.initState();
    _futureNews = _respository.getTopHeadlines();
  }

  Future<void> _retry() async {
    setState(() {
      _futureNews = _respository.getTopHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Headlines')),
      body: RefreshIndicator(
        onRefresh: _retry,
        child: FutureBuilder<List<Article>>(
          future: _futureNews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 300),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
            if (snapshot.hasError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 200),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text('Failed to load news')),
                      const SizedBox(height: 15),
                      Center(
                        child: ElevatedButton(
                          onPressed: _retry,
                          child: const Text('Retry'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            final articles = snapshot.data ?? [];
            if (articles.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 300),
                  Center(child: Text('No news found')),
                ],
              );
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleCard(article: article);
              },
            );
          },
        ),
      ),
    );
  }
}
