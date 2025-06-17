import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/injection_container.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/presentation/chat/chat_page.dart';

import 'bloc/user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(create: (context) => UserBloc(getAllUsers: getIt()),
        child: Column(
          children: [
            Expanded(child: _buildUserList(context)),
          ],
        )) ,
      ),
    );
  }

  Widget _buildUserList(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          context.read<UserBloc>().add(GetAllUsersEvent(user.id));
          return const Center(child: Text('No users yet'));
        } else if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UsersLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final userItem = state.users[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        origin:user,
                        participant: userItem,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(userItem.userName),
                  subtitle: Text(userItem.email),
                  trailing: Icon(Icons.message),
                ),
              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Unknown state'));
      },
    );
  }
}