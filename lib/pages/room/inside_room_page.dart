import 'package:flutter/material.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/utils/constants.dart';

class InsideRoomPage extends StatelessWidget {
  const InsideRoomPage({Key? key, required this.room}) : super(key: key);
  final RoomModelResponse room;

  @override
  Widget build(BuildContext context) {
    // UI screen size
    Size size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height;

    return Scaffold(
      backgroundColor: bluePrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        iconSize: deviceWidth * 0.09,
                        color: orangePrimary)
                  ],
                ),
                Text(
                  room.roomName,
                  style: TextStyle(fontSize: 15, color: whitePrimary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
