class Message {
  int? id;
  String? userId;
  String? roomId;
  String? message;
  DateTime? timestamp;

  Message({
    this.id,
    this.userId,
    this.roomId,
    this.message,
    this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      userId: json['userId'],
      roomId: json['roomId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'roomId': roomId,
      'message': message,
      'timestamp': timestamp!.toIso8601String(),
    };
  }
}
