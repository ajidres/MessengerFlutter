import 'package:flutter/material.dart';
import 'package:messenger/core/date_extensions.dart';
import 'package:messenger/data/models/conversation_model.dart';
import 'package:messenger/data/models/message_model.dart';

class ConversationItem extends StatelessWidget {
  final ConversationModel conversation;
  final VoidCallback onTap;

  const ConversationItem({super.key, required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(conversation.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(conversation.originParticipant),
      trailing: Text(
        conversation.lastMessageTime.formatTime(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onTap: onTap,
    );
  }
}
