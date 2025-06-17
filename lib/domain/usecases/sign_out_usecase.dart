import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';

import 'package:messenger/domain/repositories/auth_repository.dart';

class SignOutUseCase{
  final AuthRepository repository;

  SignOutUseCase({required this.repository});

  Future<Either<String, void>> call() async {
    return await repository.signOut();
  }
}
