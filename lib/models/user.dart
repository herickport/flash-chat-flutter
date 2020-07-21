class User {
  User({this.id, this.email, this.password});

  User.fromMap(Map<String, dynamic> map) {
    id = map['uid'];
    email = map['email'];
  }

  String id;
  String email;
  String password;
}
