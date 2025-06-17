import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/injection_container.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/presentation/chat/bloc/chat_bloc.dart';
import 'package:messenger/presentation/chat/conversations_page.dart';
import 'package:messenger/presentation/users/bloc/user_bloc.dart';
import 'package:messenger/presentation/users/user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Messenger'),
            bottom: const TabBar(
              indicatorColor: Colors.purpleAccent,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Conversations',),
                Tab(text: 'Users',),
              ],
            ), ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  TabBarView(
            children: [
              ConversationsPage(user: user),
              UserPage(user: user)
            ],
          ),
        ),
      ),
    );
  }
}
