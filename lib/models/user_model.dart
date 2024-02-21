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

// -------- Account User Data ----------//

class UserAccountDataResponse {
  final String lastLogin;
  final String dateOnCreation;
  final String username;
  final String email;
  final int id;

  const UserAccountDataResponse(
      {required this.lastLogin,
      required this.dateOnCreation,
      required this.email,
      required this.username,
      required this.id});
}

class ChangeUserPasswordRequest {
  final String oldPassword;
  final String newPassword;

  const ChangeUserPasswordRequest(
      {required this.newPassword, required this.oldPassword});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_password': oldPassword,
      'new_password': newPassword,
    };
    return map;
  }
}
