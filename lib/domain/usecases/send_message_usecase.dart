import 'package:messenger/data/models/message_model.dart';
import 'package:messenger/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(MessageModel message) {
    return repository.sendMessage(message);
  }
}