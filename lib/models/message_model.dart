// -------- Message ----------//
class MessageRequest {
  final String message;
  final String username;
  final String roomID;

  MessageRequest(
      {required this.message, required this.username, required this.roomID});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "username": username,
      "message": message,
      "unique_id": roomID
    };
    return map;
  }
}

class MessageResponse {
  final String message;
  final String username;
  final String type = "";

  MessageResponse({required this.message, required this.username, type});

  // Factory method to create a Message object from JSON data
  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
        username: json['username'],
        message: json['message'],
        type: json['type']);
  }

  // Convert Message object to JSON format
  Map<String, dynamic> toJson() {
    return {'username': username, 'message': message, 'type': type};
  }
}
