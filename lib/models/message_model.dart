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
