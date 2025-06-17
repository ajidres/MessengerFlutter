import 'package:firebase_database/firebase_database.dart';
import 'package:messenger/data/models/conversation_model.dart';
import 'package:messenger/data/models/message_model.dart';

abstract class ChatRepository {
  Stream<DatabaseEvent> getChat();
  Future<void> sendMessage(MessageModel message);
}