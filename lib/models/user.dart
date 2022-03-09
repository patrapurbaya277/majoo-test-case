// class User {
//   String? email;
//   String? userName;
//   String? password;

//   User({this.email, this.userName, this.password});

//   factory User.fromMap(Map<String, dynamic> json) => User(
//         email: json['email'],
//         password: json['password'],
//         userName: json['username'],
//       );

//   Map<String, dynamic> toJson() =>
//       {'email': email, 'password': password, 'username': userName};

//   @override
//   String toString() {
//     return 'User{email: $email, username: $userName, password: $password}';
//   }
// }

class User {
  int? id;
  String? email;
  String? username;
  String? password;

  User({
    this.email,
    this.id,
    this.username,
    this.password,
  });

  User.fromMap(dynamic map) {
    username = map['username'];
    password = map['password'];
    email = map['email'];
    id = map['id'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map["email"] = email;
    map["id"] = id;
    return map;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        username: json['username'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'username': username, 'id': id};

  @override
  String toString() {
    return 'User{email: $email, username: $username, password: $password, id: $id}';
  }
}
