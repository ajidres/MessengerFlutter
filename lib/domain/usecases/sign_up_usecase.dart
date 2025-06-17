import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';

import 'package:messenger/domain/repositories/auth_repository.dart';

class SignUpUseCase{
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<String, UserModel>> call(String email, String password) async {
    return await repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
