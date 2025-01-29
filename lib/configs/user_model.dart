UserData userDetailsfromJson(Map<String, dynamic> str) =>
    UserData.fromJson((str));

class UserData {
  UserData({
    required this.id,
    required this.userName,
    required this.email,
    required this.roles,
  });

  final String? id;
  final String? userName;
  final String? email;
  final List<String> roles;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"] ?? '',
      userName: json["userName"] ?? '',
      email: json["email"] ?? '',
      roles: json["roles"] == null
          ? []
          : List<String>.from(json["roles"]!.map((x) => x)),
    );
  }
}
