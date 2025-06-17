import 'package:firebase_database/firebase_database.dart';
import 'package:messenger/data/datasources/chat_remote_data_source.dart';
import 'package:messenger/data/models/conversation_model.dart';
import 'package:messenger/data/models/message_model.dart';
import 'package:messenger/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<DatabaseEvent> getChat() {
    return remoteDataSource.getChat();
  }

  @override
  Future<void> sendMessage(MessageModel message) {
    return remoteDataSource.sendMessage(message);
  }

}