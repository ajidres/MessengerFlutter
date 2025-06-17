import 'package:fpdart/fpdart.dart';
import 'package:messenger/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<String, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<String, void>> signOut();
}