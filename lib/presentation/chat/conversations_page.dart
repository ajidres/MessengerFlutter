import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/injection_container.dart';
import 'package:messenger/data/models/conversation_model.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/presentation/chat/bloc/chat_bloc.dart';
import 'package:messenger/presentation/chat/widget/conversation_item.dart';
import 'package:messenger/presentation/chat/chat_page.dart';

class ConversationsPage extends StatelessWidget {
  final UserModel user;

  const ConversationsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(create: (context) => ChatBloc(sendMessage: getIt(),getChat: getIt())..add(LoadConversation(user.id)),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(child: Text(state.message));
          } else if (state is ConversationsLoaded && state.conversations.isNotEmpty) {
            return _buildConversationsList(state.conversations);
          } else {
            return const Center(child: Text('No conversations yet'));
          }
        },
      ),),
    );
  }

  Widget _buildConversationsList(List<ConversationModel> conversations) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ConversationItem(
          conversation: conversation,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  origin: user,
                  participant: UserModel.empty()..id=conversations[index].originParticipantId,
                ),
              ),
            );
          },
        );
      },
    );
  }
}