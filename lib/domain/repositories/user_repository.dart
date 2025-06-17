import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<String, void>> createUser(UserModel user);

  Future<Either<String, List<UserModel>>> getAllUsers();
}