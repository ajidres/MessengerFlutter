import 'package:firebase_database/firebase_database.dart';
import 'package:messenger/data/models/conversation_model.dart';
import 'package:messenger/data/models/message_model.dart';

abstract class ChatRemoteDataSource {
  Stream<DatabaseEvent> getChat();
  Future<void> sendMessage(MessageModel message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final DatabaseReference database;

  ChatRemoteDataSourceImpl({required this.database});

  @override
  Stream<DatabaseEvent> getChat() {
    return database.child('conversations').onValue;
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final conversationRef = database.child('conversations/${message.key}');
    await conversationRef.child('${message.timestamp.millisecondsSinceEpoch}').set(message.toMap());
  }

}
