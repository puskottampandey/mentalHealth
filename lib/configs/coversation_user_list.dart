class ConversionUpdate {
  ConversionUpdate({
    required this.conversationId,
    required this.name,
    required this.isGroupChat,
    required this.lastActiveAt,
    required this.participants,
    required this.recentMessage,
  });

  final String? conversationId;
  final String? name;
  final bool? isGroupChat;
  final DateTime? lastActiveAt;
  final List<Participant> participants;
  final RecentMessage? recentMessage;

  factory ConversionUpdate.fromJson(Map<String, dynamic> json) {
    return ConversionUpdate(
      conversationId: json["conversationId"] ?? '',
      name: json["name"] ?? '',
      isGroupChat: json["isGroupChat"] ?? false,
      lastActiveAt: DateTime.tryParse(json["lastActiveAt"] ?? ""),
      participants: json["participants"] == null
          ? []
          : List<Participant>.from(
              json["participants"]!.map((x) => Participant.fromJson(x))),
      recentMessage: json["recentMessage"] == null
          ? RecentMessage.fromJson({})
          : RecentMessage.fromJson(json["recentMessage"] ?? {}),
    );
  }
}

class Participant {
  Participant({
    required this.participantId,
    required this.role,
  });

  final String? participantId;
  final int? role;

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      participantId: json["participantId"] ?? "",
      role: json["role"] ?? '',
    );
  }
}

class RecentMessage {
  RecentMessage({
    required this.messageId,
    required this.message,
    required this.isRead,
  });

  final String? messageId;
  final String? message;
  final bool? isRead;

  factory RecentMessage.fromJson(Map<String, dynamic> json) {
    return RecentMessage(
      messageId: json["messageId"] ?? "",
      message: json["message"] ?? '',
      isRead: json["isRead"] ?? false,
    );
  }
}

List<ConversionUpdate> conversationListFromJson(List<dynamic> str) =>
    List<ConversionUpdate>.from((str).map((x) => ConversionUpdate.fromJson(x)));
