List<ChatList> chatListFromJson(List<dynamic> str) =>
    List<ChatList>.from((str).map((x) => ChatList.fromJson(x)));

class ChatList {
  ChatList({
    required this.id,
    required this.userId,
    required this.certification,
    required this.specialization,
    required this.bio,
    required this.yearsOfExperience,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.firstName,
    required this.lastName,
    required this.conversationId,
  });

  final String? id;
  final String? userId;
  final String? certification;
  final String? specialization;
  final String? bio;
  final int? yearsOfExperience;
  final String? userName;
  final String? email;
  final dynamic phoneNumber;
  final dynamic profilePictureUrl;
  final String? firstName;
  final String? lastName;
  final String conversationId;
  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
        id: json["id"] ?? '',
        userId: json["userId"] ?? '',
        certification: json["certification"] ?? "",
        specialization: json["specialization"] ?? '',
        bio: json["bio"] ?? '',
        yearsOfExperience: json["yearsOfExperience"] ?? '',
        userName: json["userName"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        profilePictureUrl: json["profilePictureUrl"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? '',
        conversationId: json["conversationId"] ?? '');
  }
}
