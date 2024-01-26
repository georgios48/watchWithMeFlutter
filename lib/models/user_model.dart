class RegisterUserRequest {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterUserRequest(
      {required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'email': email,
      'password': password,
      'password check': confirmPassword
    };
    return map;
  }
}

// -------- Login User ----------//

class LoginUserRequest {
  final String username;
  final String password;

  const LoginUserRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'password': password,
    };
    return map;
  }
}
