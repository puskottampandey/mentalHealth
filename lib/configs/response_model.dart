ResponseModel responseModelLinksFromJson(Map<String, dynamic> str) =>
    ResponseModel.fromJson((str));

class ResponseModel {
  Links? links;
  int? currentPage;
  int? total;
  int? perPage;
  int? totalPages;
  dynamic data;

  ResponseModel({
    this.links,
    this.currentPage,
    this.total,
    this.perPage,
    this.totalPages,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        currentPage: json["current_page"],
        total: json["total"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        data: json["data"] ?? json,
      );
}

class Links {
  final String? next;
  final String? previous;

  Links({
    this.next,
    this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
        previous: json["previous"],
      );
}
