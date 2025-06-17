import 'package:firebase_database/firebase_database.dart';
import 'package:messenger/domain/repositories/chat_repository.dart';

class GetChatUseCase {
  final ChatRepository repository;

  GetChatUseCase(this.repository);

  Stream<DatabaseEvent> call() {
    return repository.getChat();
  }
}