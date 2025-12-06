class MessageBubble {
  final bool isUser;
  final String message;
  final DateTime time;

  MessageBubble({
    required this.isUser,
    required this.message,
    required this.time,
  });

  MessageBubble copyWith({bool? isUser, String? message, DateTime? time}) {
    return MessageBubble(
      isUser: isUser ?? this.isUser,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'time': time.toIso8601String(),
    'isUser': isUser,
  };

  factory MessageBubble.fromJson(Map<String, dynamic> json) => MessageBubble(
    message: json['message'] as String,
    time: DateTime.parse(json['time'] as String),
    isUser: json['isUser'] as bool,
  );

  int compareTo(MessageBubble other) {
    return time.compareTo(other.time);
  }
}
