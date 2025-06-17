import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<String, UserModel>> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

