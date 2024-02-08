class RoomModelResponse {
  String uniqueID;
  int ownerID;
  String roomName;

  RoomModelResponse(
      {required this.uniqueID, required this.ownerID, required this.roomName});

  factory RoomModelResponse.fromJson(Map<String, dynamic> json) {
    return RoomModelResponse(
        uniqueID: json['unique_id'],
        ownerID: json["owner_id"],
        roomName: json["name"]);
  }
}

class RoomModelRequest {
  String? roomName;
  String? roomPassword;

  RoomModelRequest({this.roomName, this.roomPassword});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {'name': roomName, 'password': roomPassword};
    return map;
  }
}

// -- Join and Leave room models -- //
class JoinRoomRequest {
  String roomID;
  String? roomPassword;

  JoinRoomRequest({required this.roomID, this.roomPassword});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {'room': roomID, 'password': roomPassword};
    return map;
  }
}
