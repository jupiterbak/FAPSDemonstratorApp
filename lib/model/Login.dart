class Login {
  String userName;
  String passHashed;

  Login({this.userName, this.passHashed});

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'passHashed': passHashed,
  };
}