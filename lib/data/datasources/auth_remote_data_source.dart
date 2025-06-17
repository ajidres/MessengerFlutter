import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromAuth(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Authentication Failed';
    }catch(e){
      throw 'Authentication Failed';
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromAuth(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Registration Failed';
    }catch(e){
      throw 'Registration Failed';
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    }on FirebaseAuthException catch (e) {
      throw e.message ?? 'Sign out Failed';
    }catch(e){
      throw 'Sign out Failed';
    }
  }
}