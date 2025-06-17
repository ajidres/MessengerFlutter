import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createUser(UserModel user);
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final querySnapshot = await firestore.collection('users').get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromCloud(doc.data()))
        .toList();
  }
}