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

class RegisterUserResponse {
  String? success;
  String? error;

  RegisterUserResponse({required this.success, required this.error});

  static fromJson(Map<String, dynamic> json) {
    RegisterUserResponse response =
        RegisterUserResponse(success: json["Success"], error: json["Error"]);

    return response;
  }
}

// -------- Register User ----------//

