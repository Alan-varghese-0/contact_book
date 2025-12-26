import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:contact_book/src/features/user/domain/entities/user_entity.dart';
import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserRepository repo) : super(userinitial()) {
    on<UserEvent>((event, emit) {
      emit(userloading());
      final user = repo.getusers();
      emit(userloaded(user));
    });
    on<addUser>((event, emit) async {
      final user = UserEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        phone: event.phone,
        age: event.age,
        imagepath: event.imagepath,
      );
      await repo.addUser(user);
      final users = repo.getusers();
      emit(userloaded(users));
    });
  }
}
