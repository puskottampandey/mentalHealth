List<NewsModel> newsListFromJson(List<dynamic> str) =>
    List<NewsModel>.from((str).map((x) => NewsModel.fromJson(x)));

class NewsModel {
  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    required this.publishedAt,
    required this.urlToImage,
  });

  final String? title;
  final String? description;
  final String? url;
  final String? source;
  final DateTime? publishedAt;
  final String? urlToImage;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      source: json["source"],
      publishedAt: DateTime.tryParse(
        json["publishedAt"] ?? "",
      ),
    );
  }
}
