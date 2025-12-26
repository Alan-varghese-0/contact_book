import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_bloc.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_state.dart';
import 'package:contact_book/src/features/user/presentation/pages/add_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPages extends StatelessWidget {
  final UserRepository repo;
  const UserListPages({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(repo)..add(loadUser()),
      child: Scaffold(
        appBar: AppBar(title: const Text("users")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, State) {
            if (State is userloading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (State is userloaded) {
              if (State.user.isEmpty) {
                return const Center(child: Text("No users found"));
              }
              return ListView.builder(
                itemCount: State.user.length,
                itemBuilder: (context, index) {
                  final user = State.user[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.phone),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUserPage()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
