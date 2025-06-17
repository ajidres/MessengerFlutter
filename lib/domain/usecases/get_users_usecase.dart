import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Future<Either<String, List<UserModel>>> call() async {
    return await repository.getAllUsers();
  }
}