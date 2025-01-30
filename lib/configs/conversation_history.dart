ConversationHistoryList historyLinkFromJson(Map<String, dynamic> str) =>
    ConversationHistoryList.fromJson(str);

class ConversationHistoryList {
  ConversationHistoryList({
    required this.conversationId,
    required this.name,
    required this.isGroupChat,
    required this.lastActiveAt,
    required this.participants,
    required this.messages,
  });

  final String? conversationId;
  final String? name;
  final bool? isGroupChat;
  final DateTime? lastActiveAt;
  final List<Participant> participants;
  final List<Message> messages;

  factory ConversationHistoryList.fromJson(Map<String, dynamic> json) {
    return ConversationHistoryList(
      conversationId: json["conversationId"] ?? '',
      name: json["name"] ?? "",
      isGroupChat: json["isGroupChat"] ?? '',
      lastActiveAt: DateTime.tryParse(json["lastActiveAt"] ?? ""),
      participants: json["participants"] == null
          ? []
          : List<Participant>.from(
              json["participants"]!.map((x) => Participant.fromJson(x))),
      messages: json["messages"] == null
          ? []
          : List<Message>.from(
              json["messages"]!.map((x) => Message.fromJson(x))),
    );
  }
}

class Message {
  Message({
    required this.messageId,
    required this.senderId,
    required this.messageContent,
    required this.sentAt,
    required this.attachments,
  });

  final String? messageId;
  final String? senderId;
  final String? messageContent;
  final DateTime? sentAt;
  final List<dynamic> attachments;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json["messageId"] ?? "",
      senderId: json["senderId"] ?? "",
      messageContent: json["messageContent"] ?? '',
      sentAt: DateTime.tryParse(json["sentAt"] ?? ""),
      attachments: json["attachments"] == null
          ? []
          : List<dynamic>.from(json["attachments"]!.map((x) => x)),
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
