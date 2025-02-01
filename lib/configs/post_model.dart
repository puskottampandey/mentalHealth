List<PostModel> postListFromJson(List<dynamic> str) =>
    List<PostModel>.from((str).map((x) => PostModel.fromJson(x)));

class PostModel {
  PostModel({
    required this.id,
    required this.user,
    required this.primaryMood,
    required this.secondaryMood,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.isLikedByUser,
  });

  final String? id;
  final User? user;
  final String? primaryMood;
  final String? secondaryMood;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  int likesCount;
  final int? commentsCount;
  bool isLikedByUser;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"] ?? "",
      user: json["user"] == null
          ? User.fromJson({})
          : User.fromJson(json["user"]),
      primaryMood: json["primaryMood"] ?? '',
      secondaryMood: json["secondaryMood"] ?? '',
      title: json["title"] ?? '',
      content: json["content"] ?? '',
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      likesCount: json["likesCount"] ?? 0,
      commentsCount: json["commentsCount"] ?? 0,
      isLikedByUser: json["isLikedByUser"] ?? false,
    );
  }
}

class User {
  User({
    required this.userId,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
  });

  final String? userId;
  final String? userName;
  final String? email;
  final String? profilePictureUrl;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"] ?? '',
      userName: json["userName"] ?? "",
      email: json["email"] ?? '',
      profilePictureUrl: json["profilePictureUrl"] ?? '',
    );
  }
}
