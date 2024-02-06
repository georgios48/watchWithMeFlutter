import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/pages/main_page.dart';
import 'package:watch_with_me/providers/room_provider.dart';
import 'package:watch_with_me/servicesAPI/room_service.dart';
import 'package:watch_with_me/utils/constants.dart';

import '../../utils/awesome_snackbar.dart';

class CreateRoomScreen extends ConsumerWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final roomNameTextController = TextEditingController();
    final roomPasswordController = TextEditingController();
    final roomService = RoomService();

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
                  controller: roomNameTextController,
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
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  controller: roomPasswordController,
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
                  text: "Create room",
                  color: orangePrimary,
                  press: () async {
                    RoomModelRequest roomObject = RoomModelRequest(
                        roomName: roomNameTextController.text,
                        roomPassword: roomPasswordController.text);
                    try {
                      await roomService.createRoom(roomObject).then((value) {
                        SnackBar snackBar =
                            CustomSnackbar().displaySnacbar(value[0], value[1]);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);

                        if (value[0] == 201) {
                          Future.delayed(const Duration(seconds: 2));

                          // refresh the state of roomProvider
                          ref.invalidate(roomDataProvider);
                          ref.read(roomDataProvider);

                          Future.delayed(const Duration(seconds: 3));
                          // removes all previous pages
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      });
                    } on Exception catch (e) {
                      SnackBar snackBar =
                          CustomSnackbar().displaySnacbar(0, e.toString());

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}
