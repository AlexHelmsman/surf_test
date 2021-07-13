import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user.dart';

Future<List<User>> getUsers() async {
  final result =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (result.statusCode == 200) {
    final userList = <User>[];
    final userListJson = jsonDecode(result.body);

    for (var map in userListJson) {
      userList.add(User.fromJson(map));
    }
    return userList;
  } else {
    throw Exception('Error loading');
  }
}
