import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/injection_container.dart';
import 'package:messenger/data/models/message_model.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/presentation/chat/bloc/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  final UserModel participant;
  final UserModel origin;
  const ChatPage({super.key, required this.participant, required this.origin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(participant.userName)),
      body: BlocProvider(
        create:
            (context) =>
                ChatBloc(sendMessage: getIt(), getChat: getIt())
                  ..add(LoadChat(origin.id, participant.id)),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoaded) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: ListView.builder(
                        itemCount: state.conversations.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment:
                                state.conversations[index].senderId == origin.id
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        state.conversations[index].senderId == origin.id
                                            ? Colors.green
                                            : Colors.blue,
                                    width: 1,
                                  ),
                                  //Border.all
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      state.conversations[index].senderId == origin.id
                                          ? Colors.green.withValues(alpha: 0.2)
                                          : Colors.blue.withValues(alpha: 0.2),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
                                  child: Text(state.conversations[index].content),
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return BuildMessageInput(origin: origin, participant: participant, keySaved: state is ChatLoaded && state.conversations.isNotEmpty?(state.conversations.first.key):'');
              },
            )
          ],
        ),
      ),
    );
  }
}

class BuildMessageInput extends StatefulWidget {
  const BuildMessageInput({super.key, required this.participant, required this.origin, required this.keySaved});

  final UserModel participant;
  final UserModel origin;
  final String keySaved;

  @override
  State<BuildMessageInput> createState() => _BuildMessageInputState();
}

class _BuildMessageInputState extends State<BuildMessageInput> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLength: 50,
              minLines: 1,
              maxLines: 3,

              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                counterText: ""
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {

                final message = MessageModel(
                  key: widget.keySaved.isNotEmpty?widget.keySaved:'${widget.origin.id}|${widget.participant.id}',//widget.creator?'${widget.origin.id}|${widget.participant.id}':'${widget.participant.id}|${widget.origin.id}',
                  senderId: widget.origin.id,
                  senderName: widget.origin.userName,
                  destinationId: widget.participant.id,
                  destinationName: widget.participant.userName,
                  content: _messageController.text,
                  timestamp: DateTime.now(),
                );

                context.read<ChatBloc>().add(SendMessageEvent(message));
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
