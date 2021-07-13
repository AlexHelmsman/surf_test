import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'user_list_screen.dart';

final greetingsDelay = Future.delayed(const Duration(milliseconds: 1000));

class GreetingsScreen extends StatelessWidget {
  GreetingsScreen({Key? key}) : super(key: key);
  final storage = GetStorage();
  late final email = storage.read('userLogin')['email'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: greetingsDelay,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: (Text('ERROR')));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return const UserListScreen();
            } else {
              return Center(
                child: Text('Привет, $email'),
              );
            }
          }),
    );
  }
}
