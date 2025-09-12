class SignInModel {
  final String username;
  final String password;

  SignInModel({required this.username, required this.password});

  SignInModel copyWith({String? username, String? password}) {
    return SignInModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}