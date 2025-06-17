import 'package:messenger/data/models/user_model.dart';

class ConversationModel {
  final String id;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String originParticipant;
  final String originParticipantId;


  ConversationModel({
    required this.id,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.originParticipant,
    required this.originParticipantId
  });

  factory ConversationModel.empty() {
    return ConversationModel(
      id:'',
      lastMessage : '',
      lastMessageTime:DateTime.now(),
      originParticipant : '',
        originParticipantId:'',
    );
  }

}