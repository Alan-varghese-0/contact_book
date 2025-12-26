import 'package:contact_book/src/features/user/domain/entities/user_entity.dart';

abstract class UserState {}

class userinitial extends UserState {}

class userloading extends UserState {}

class userloaded extends UserState {
  final List<UserEntity> user;
  userloaded(this.user);
}
