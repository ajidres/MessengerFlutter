import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/domain/usecases/create_user_usecase.dart';
import 'package:messenger/domain/usecases/get_users_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final GetUsersUseCase getAllUsers;

  UserBloc({
    required this.getAllUsers,
  }) : super(UserInitial()) {
    on<GetAllUsersEvent>(_onGetAllUsers);
  }


  Future<void> _onGetAllUsers(GetAllUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getAllUsers();
    result.fold(
          (failure) => emit(UserError(failure)),
          (users) {
            users.removeWhere((data)=>data.id==event.userId);
            emit(UsersLoaded(users: users));
          },
    );
  }
}