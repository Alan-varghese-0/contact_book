import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_bloc.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_state.dart';
import 'package:contact_book/src/features/user/presentation/pages/add_user_page.dart';
import 'package:contact_book/src/features/user/presentation/pages/filter_popup.dart';
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
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                "contacts",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: "Search user...",
                              border: InputBorder.none,
                            ),
                            onChanged: (query) {
                              ctx.read<UserBloc>().add(
                                searchUser(query: query),
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          showDialog(
                            context: ctx,
                            barrierDismissible: true,
                            builder: (_) {
                              return BlocProvider.value(
                                value: ctx.read<UserBloc>(),
                                child: const FilterPopup(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: user.imagepath.isEmpty
                                        ? null
                                        : FileImage(File(user.imagepath)),
                                    child: user.imagepath.isEmpty
                                        ? const Icon(Icons.person, size: 28)
                                        : null,
                                  ),
                                  title: Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      "📞 ${user.phone}\nAge: ${user.age}",
                                      style: const TextStyle(height: 1.4),
                                    ),
                                  ),
                                ),
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
              backgroundColor: Colors.blue,
              elevation: 4,
              child: const Icon(Icons.add, size: 30),
              onPressed: () {
                showDialog(
                  context: ctx, // <-- IMPORTANT
                  barrierDismissible: true,
                  builder: (_) {
                    return BlocProvider.value(
                      value: ctx.read<UserBloc>(), // <-- GIVE SAME BLOC
                      child: Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const AddUserPage(),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
