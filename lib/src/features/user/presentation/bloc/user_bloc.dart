import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:contact_book/src/features/user/domain/entities/user_entity.dart';
import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repo;

  List<UserEntity> users = []; // master list
  int page = 1;
  final int limit = 3;

  UserBloc(this.repo) : super(userinitial()) {
    // LOAD USERS
    on<loadUser>((event, emit) {
      emit(userloading());
      users = repo.getusers();
      final firstBatch = users.take(limit).toList();
      emit(userloaded(firstBatch));
    });

    // ADD USER
    on<addUser>((event, emit) async {
      final user = UserEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        phone: event.phone,
        age: event.age,
        imagepath: event.imagepath,
      );

      await repo.addUser(user);

      users = repo.getusers();
      final current = users.take(page * limit).toList();
      emit(userloaded(current));
    });

    // SEARCH
    on<searchUser>((event, emit) {
      final result = users
          .where(
            (u) =>
                u.name.toLowerCase().contains(event.query.toLowerCase()) ||
                u.phone.contains(event.query),
          )
          .toList();
      emit(userloaded(result));
    });

    // SORT OLDER
    on<sortolder>((event, emit) {
      final sorted = users.where((u) => u.age >= 60).toList();
      emit(userloaded(sorted));
    });

    // SORT YOUNGER
    on<sortyounger>((event, emit) {
      final sorted = users.where((u) => u.age < 60).toList();
      emit(userloaded(sorted));
    });

    // RESET SORT
    on<sortreset>((event, emit) {
      final current = users.take(page * limit).toList();
      emit(userloaded(current));
    });

    // LAZY LOAD
    on<loadmore>((event, emit) {
      page++;
      final more = users.take(page * limit).toList();
      emit(userloaded(more));
    });
  }
}
