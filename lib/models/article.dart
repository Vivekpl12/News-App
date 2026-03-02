class Article{
  final String title;
  final String? description;
  final String? imageUrl;
  final DateTime? publishedAt;
  Article({
    required this.title,
    this.description,
    this.imageUrl,
    this.publishedAt,
  });
  factory Article.fromJson(Map<String,dynamic>json){
    return Article(
      title: json['title']?? '',
      description: json['description'],
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
      ?DateTime.parse(json['publishedAt'])
      :null,
    );
  }
}