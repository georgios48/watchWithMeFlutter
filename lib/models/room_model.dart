class RoomModel {
  String uniqueID;
  int ownerID;
  String roomName;

  RoomModel(
      {required this.uniqueID, required this.ownerID, required this.roomName});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        uniqueID: json['unique_id'],
        ownerID: json["owner_id"],
        roomName: json["name"]);
  }
}
