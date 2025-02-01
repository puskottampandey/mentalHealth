AuthResponse authResponseLinkFromJson(Map<String, dynamic> str) =>
    AuthResponse.fromJson(str);

class AuthResponse {
  String? token;
  String? expiry;
  AuthResponse({
    this.token,
    this.expiry,
  });
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token']?? '',
      expiry: json['expiry']?? '',
    );
  }
}
