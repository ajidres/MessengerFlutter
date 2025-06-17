part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageModel> conversations;

  ChatLoaded({required this.conversations});
}

class ChatError extends ChatState {
  final String message;
  ChatError({required this.message});
}

class ConversationsLoaded extends ChatState {
  final List<ConversationModel> conversations;
  ConversationsLoaded({required this.conversations});
}