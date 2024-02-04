import 'package:flutter/material.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/utils/constants.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _roomNameTextController = TextEditingController();

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
              SizedBox(height: deviceHeight * 0.04),
              Align(
                alignment: Alignment.center,
                child: Text("Create your room",
                    style: TextStyle(
                        fontFamily: 'Chalet',
                        fontSize: deviceWidth * 0.07,
                        color: orangePrimary,
                        fontWeight: FontWeight.w300,
                        height: deviceHeight * 0.001)),
              ),
              SizedBox(height: deviceHeight * 0.094),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Room name",
                    style: TextStyle(
                        fontFamily: 'Chalet',
                        fontSize: deviceWidth * 0.04,
                        color: whitePrimary,
                        fontWeight: FontWeight.w100,
                        height: deviceHeight * 0.001)),
              ),
              SizedBox(height: deviceHeight * 0.008),

              // room name textField
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  controller: _roomNameTextController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: whitePrimary,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      hintText: 'Enter room name (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 174, 173, 173))),
                ),
              ),

              SizedBox(height: deviceHeight * 0.008),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Room password",
                    style: TextStyle(
                        fontFamily: 'Chalet',
                        fontSize: deviceWidth * 0.04,
                        color: whitePrimary,
                        fontWeight: FontWeight.w100,
                        height: deviceHeight * 0.001)),
              ),
              SizedBox(height: deviceHeight * 0.008),

              // password textField
              SizedBox(
                // TODO: create a validator for password. empty string is not considered as null in the backend
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  controller: _roomNameTextController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: whitePrimary,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      hintText: 'Enter room password (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 174, 173, 173))),
                ),
              ),

              SizedBox(height: deviceHeight * 0.07),

              RoundedButton(
                  text: "Create room", color: orangePrimary, press: () {})
            ],
          ),
        ),
      )),
    );
  }
}
