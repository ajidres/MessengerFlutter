
import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/datasources/user_remote_data_source.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> createUser(UserModel user) async {
    try {
      await remoteDataSource.createUser(user);
      return const Right(null);
    }  catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<UserModel>>> getAllUsers() async {
    try {
      final user = await remoteDataSource.getAllUsers();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

}