class User {
  final String id;
  final String userName;
  final String rol;
  final String password;

  User(
      {required this.id,
      required this.userName,
      required this.rol,
      required this.password});
}

List<User> users = [User(id: '123', userName: 'a', rol: 'a', password: 'a')];
