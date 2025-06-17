part of 'chat_bloc.dart';

abstract class ChatEvent {}

class LoadConversation extends ChatEvent {
  final String originId;
  LoadConversation( this.originId);
}

class LoadChat extends ChatEvent {
  final String originId;
  final String senderId;
  LoadChat( this.originId, this.senderId);
}

class UpdateChat extends ChatEvent {
  final List<MessageModel> conversations;
  UpdateChat(this.conversations);
}

class SendMessageEvent extends ChatEvent {
  final MessageModel message;
  SendMessageEvent(this.message);
}

class UpdateConversation extends ChatEvent {
  final List<ConversationModel> conversations;
  UpdateConversation(this.conversations);
}