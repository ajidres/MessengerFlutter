import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger/data/datasources/auth_remote_data_source.dart';
import 'package:messenger/data/datasources/chat_remote_data_source.dart';
import 'package:messenger/data/datasources/user_remote_data_source.dart';
import 'package:messenger/data/repositories/auth_repository_impl.dart';
import 'package:messenger/data/repositories/chat_repository_impl.dart';
import 'package:messenger/data/repositories/user_repository_impl.dart';
import 'package:messenger/domain/repositories/auth_repository.dart';
import 'package:messenger/domain/repositories/chat_repository.dart';
import 'package:messenger/domain/repositories/user_repository.dart';
import 'package:messenger/domain/usecases/create_user_usecase.dart';
import 'package:messenger/domain/usecases/get_chat_usecase.dart';
import 'package:messenger/domain/usecases/get_users_usecase.dart';
import 'package:messenger/domain/usecases/send_message_usecase.dart';
import 'package:messenger/domain/usecases/sign_in_usecase.dart';
import 'package:messenger/domain/usecases/sign_out_usecase.dart';
import 'package:messenger/domain/usecases/sign_up_usecase.dart';
import 'package:messenger/presentation/auth/bloc/auth_bloc.dart';
import 'package:messenger/presentation/chat/bloc/chat_bloc.dart';
import 'package:messenger/presentation/users/bloc/user_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<DatabaseReference>(() => FirebaseDatabase.instance.ref());
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data sources
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(database: getIt()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: getIt()),
  );
  getIt.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: getIt()));

  // Use cases
  getIt.registerLazySingleton<GetChatUseCase>(() => GetChatUseCase(getIt()));
  getIt.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase(getIt()));
  getIt.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: getIt()));
  getIt.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(repository: getIt()));
  getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: getIt()));
  getIt.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(repository: getIt()));

  // BLoC
  getIt.registerLazySingleton<ChatBloc>(
    () => ChatBloc(getChat: getIt(), sendMessage: getIt()),
  );
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(signInUseCase: getIt(), signOutUseCase: getIt(), signUpUseCase: getIt(),createUser: getIt()),
  );
  getIt.registerLazySingleton<UserBloc>(
        () => UserBloc(getAllUsers: getIt()),
  );
}
