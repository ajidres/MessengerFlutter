class MessageModel {
  String key;
  final String senderId;
  final String senderName;
  final String destinationId;
  final String destinationName;
  final String content;
  final DateTime timestamp;

  MessageModel({
    required this.key,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.destinationId,
    required this.destinationName,
  });


  // factory MessageModel.fromMap(Map<dynamic, dynamic> map) {
  //   return MessageModel(
  //     senderId:  map.values.last['senderId'],
  //     // receiverId:  map.values.last['senderId'],
  //     content:  map.values.last['senderId'],
  //     timestamp: DateTime.fromMillisecondsSinceEpoch( map.values.last['timestamp']),
  //   );
  // }

  factory MessageModel.fromChat(Map<dynamic, dynamic> map) {
    return MessageModel(
      key:map['key'],
      senderId:  map['senderId'],
      senderName:map['senderName'],
      destinationId:  map['destinationId'],
      destinationName:map['destinationName'],
      content:  map['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch( map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key':key,
      'senderId': senderId,
      'senderName':senderName,
      'destinationId': destinationId,
      'destinationName':destinationName,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}