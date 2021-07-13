import 'package:flutter/material.dart';
import 'package:surf_test/screen_switcher.dart';
import 'package:get_storage/get_storage.dart';

import 'user_list_api.dart';
import 'user.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  onLogout(BuildContext context) {
    final storage = GetStorage();
    storage.write('userLogin', null);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ScreenSwitcher();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
        actions: [
          IconButton(
              onPressed: () {
                onLogout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ERROR'),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Reload')),
                ],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final users = snapshot.data as List<User>;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.account_circle_outlined),
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
