import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:messenger/data/models/conversation_model.dart';
import 'package:messenger/data/models/message_model.dart';
import 'package:messenger/domain/usecases/get_chat_usecase.dart';
import 'package:messenger/domain/usecases/send_message_usecase.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatUseCase getChat;
  final SendMessageUseCase sendMessage;

  ChatBloc({required this.getChat, required this.sendMessage}) : super(ChatInitial()) {
    on<LoadChat>(_onLoadChat);
    on<SendMessageEvent>(_onSendMessage);
    on<UpdateChat>(_onUpdateChat);
    on<LoadConversation>(_onLoadConversation);
    on<UpdateConversation>(_onUpdateConversation);
  }

  void _onLoadChat(LoadChat event, Emitter<ChatState> emit) async {
    String masterKey = '${event.originId}|${event.senderId}';
    String masterKey2 = '${event.senderId}|${event.originId}';
    getChat().listen((event) {
      Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
      var dataReal = data[masterKey] ?? data[masterKey2];

      List<MessageModel> messages = [];

      dataReal?.forEach((key, values) {
        Map<dynamic, dynamic> data = values as Map<dynamic, dynamic>;
        messages.add(MessageModel.fromChat(data));
      });

      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      add(UpdateChat(messages));
    });
  }

  void _onUpdateChat(UpdateChat event, Emitter<ChatState> emit) {
    emit(ChatLoaded(conversations: event.conversations));
  }

  void _onUpdateConversation(UpdateConversation event, Emitter<ChatState> emit) {
    emit(ConversationsLoaded(conversations: event.conversations));
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      await sendMessage(event.message);
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  void _onLoadConversation(LoadConversation eventBloc, Emitter<ChatState> emit) async {
    emit(ChatLoading());

    getChat().listen((event) {
      List<ConversationModel> conversation = [];

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((keyParent, values) {
          if (keyParent.contains(eventBloc.originId)) {
            Map<dynamic, dynamic> single = values as Map<dynamic, dynamic>;

            var splitKey = keyParent.split('|');
            // var key = splitKey[1]==eventBloc.originId ? splitKey[1] : splitKey[0];

            ConversationModel conversationModel = ConversationModel(
              id: single.entries.first.value['key'],
              lastMessage: single.entries.first.value['content'],
              lastMessageTime: DateTime.fromMillisecondsSinceEpoch(
                single.entries.first.value['timestamp'],
              ),
              originParticipant:
                  single.values.first['destinationId'] == eventBloc.originId
                      ? single.values.first['senderName']
                      : single.values.first['destinationName'],
              originParticipantId:
                  single.values.first['destinationId'] == eventBloc.originId
                      ? single.values.first['senderId']
                      : single.values.first['destinationId'],
            );

            conversation.add(conversationModel);
          }
        });

        print('');

        conversation.sort((a, b) => -a.lastMessageTime.compareTo(b.lastMessageTime));

        add(UpdateConversation(conversation));
      } else {
        add(UpdateConversation(conversation));
      }
    });
  }
}
