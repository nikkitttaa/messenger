class Message {
  final String senderID;
  final String senderEmail;
  final String senderUsername;
  final String receiverID;
  final String message;
  final DateTime timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.senderUsername,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'username': senderUsername,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
