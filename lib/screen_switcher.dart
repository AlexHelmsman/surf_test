import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'login_screen.dart';
import 'greetings_screen.dart';

class ScreenSwitcher extends StatelessWidget {
  ScreenSwitcher({Key? key}) : super(key: key);

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final userLogin = storage.read('userLogin');
    if (userLogin == null) {
      return const LoginScreen();
    } else {
      return GreetingsScreen();
    }
  }
}
