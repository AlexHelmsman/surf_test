class User {
  late final int id;
  late final String name;
  late final String email;

  User.fromJson(json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
}
