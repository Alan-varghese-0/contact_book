import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_bloc.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_state.dart';
import 'package:contact_book/src/features/user/presentation/pages/add_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class UserListPages extends StatelessWidget {
  final UserRepository repo;
  const UserListPages({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(repo)..add(loadUser()),
      child: Builder(
        builder: (ctx) {
          return Scaffold(
            appBar: AppBar(title: const Text("users")),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      ctx.read<UserBloc>().add(searchUser(query: query));
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ctx.read<UserBloc>().add(sortolder());
                      },
                      child: const Text("Sort by Older"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        ctx.read<UserBloc>().add(sortyounger());
                      },
                      child: const Text("Sort by Younger"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        ctx.read<UserBloc>().add(sortreset());
                      },
                      child: const Text("Reset Sort"),
                    ),
                  ],
                ),

                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is userloading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is userloaded) {
                        if (state.user.isEmpty) {
                          return const Center(child: Text("No users found"));
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              ctx.read<UserBloc>().add(loadmore());
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: state.user.length,
                            itemBuilder: (context, index) {
                              final user = state.user[index];
                              return ListTile(
                                leading: user.imagepath.isEmpty
                                    ? const CircleAvatar(
                                        child: Icon(Icons.person),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(user.imagepath),
                                        ),
                                      ),
                                title: Text(user.name),
                                subtitle: Text(user.phone),
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final userBloc = ctx.read<UserBloc>();

                Navigator.of(ctx).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: userBloc,
                      child: const AddUserPage(),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
