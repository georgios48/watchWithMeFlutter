import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/models/user_model.dart';
import 'package:watch_with_me/servicesAPI/room_service.dart';
import 'package:watch_with_me/servicesAPI/user_service.dart';

// showing loading, error and data automatically <3
// object's state is being watched
final roomDataProvider = FutureProvider<List<RoomModelResponse>>((ref) async {
  return ref.watch(roomProvider).getUserRooms();
});

final userAccountDataProvider =
    FutureProvider<UserAccountDataResponse>((ref) async {
  return ref.watch(userAccountProvider).getUserData();
});
