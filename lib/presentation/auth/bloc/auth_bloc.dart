import 'dart:convert';

import 'package:messenger/core/constants.dart';
import 'package:messenger/core/hive_preference_client.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/domain/usecases/create_user_usecase.dart';

import 'package:messenger/domain/usecases/sign_in_usecase.dart';
import 'package:messenger/domain/usecases/sign_out_usecase.dart';
import 'package:messenger/domain/usecases/sign_up_usecase.dart';
import 'package:bloc/bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final CreateUserUseCase createUser;

  AuthBloc({required this.signInUseCase, required this.signUpUseCase, required this.signOutUseCase, required this.createUser})
    : super(AuthState()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await signInUseCase.call(event.email, event.password);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, errorMessage: failure)),
      (user) {
        user.userName = user.email.split('@')[0];
        saveDataLocal(user);
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await signUpUseCase.call(event.email, event.password);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, errorMessage: failure)),
      (user) async {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        user.userName = user.email.split('@')[0];
        var result = await createUser(user);
        saveDataLocal(user);
      },
    );
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await signOutUseCase.call();
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, errorMessage: failure)),
      (_) => emit(state.copyWith(status: AuthStatus.unauthenticated, user: null)),
    );
  }

  void saveDataLocal(UserModel user) {
    var data = jsonEncode(user.toJson());
    HivePreferenceClient.instance.setString(USER_KEY, data);
  }
}
