TherapistDetails therapistDetailsfromJson(Map<String, dynamic> str) =>
    TherapistDetails.fromJson((str));

class TherapistDetails {
  TherapistDetails({
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

  factory TherapistDetails.fromJson(Map<String, dynamic> json) {
    return TherapistDetails(
      id: json["id"] ?? '',
      userId: json["userId"],
      certification: json["certification"] ?? '',
      specialization: json["specialization"] ?? '',
      bio: json["bio"] ?? '',
      yearsOfExperience: json["yearsOfExperience"] ?? '',
      userName: json["userName"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      profilePictureUrl: json["profilePictureUrl"] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? '',
    );
  }
}
