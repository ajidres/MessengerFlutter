import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/domain/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase({required this.repository});

  Future<Either<String, void>> call(UserModel user) async {
    return await repository.createUser(user);
  }
}