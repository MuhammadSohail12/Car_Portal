class UserModel {
  int? id;
  late String userName;
  late int phoneNumber;
  late String email;
  late String password;

  UserModel(this.userName, this.phoneNumber, this.email, this.password);

  UserModel.fromMap(Map<String, dynamic> map) {
    userName = map['userName'];
    phoneNumber = map['phoneNumber'];
    email = map['email'];

    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password
    };
  }
}
