import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/pages/room/inside_room_page.dart';
import 'package:watch_with_me/pages/user/detailed_profile_page.dart';
import 'package:watch_with_me/providers/providers.dart';
import 'package:watch_with_me/pages/room/create_room_page.dart';
import 'package:watch_with_me/servicesAPI/room_service.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';
import 'package:watch_with_me/utils/constants.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // provider
    final roomListData = ref.watch(roomDataProvider);

    final roomService = RoomService();

    final roomIDController = TextEditingController();
    final roomPasswordController = TextEditingController();

    // UI screen size
    final size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height;

    return Scaffold(
        backgroundColor: bluePrimary,
        body: roomListData.when(
            data: (data) {
              List<RoomModelResponse> roomList =
                  data.map((room) => room).toList();
              return SafeArea(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: deviceWidth * 0.09,
                            icon: const Icon(Icons.person_outline,
                                color: orangePrimary),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailedProfilePage()));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: orangePrimary,
                            ),
                            iconSize: deviceWidth * 0.09,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateRoomScreen()),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: deviceHeight * 0.04),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Watch",
                            style: TextStyle(
                                fontFamily: 'Chalet',
                                fontSize: deviceWidth * 0.10,
                                color: orangePrimary,
                                fontWeight: FontWeight.w300,
                                height: deviceHeight * 0.001)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("With",
                            style: TextStyle(
                                fontFamily: 'Chalet',
                                fontSize: deviceWidth * 0.10,
                                color: whitePrimary,
                                fontWeight: FontWeight.w300,
                                height: deviceHeight * 0.001)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Me",
                            style: TextStyle(
                                fontFamily: 'Chalet',
                                fontSize: deviceWidth * 0.10,
                                color: orangePrimary,
                                fontWeight: FontWeight.w300,
                                height: deviceHeight * 0.001)),
                      ),
                      SizedBox(height: deviceHeight * 0.04),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Join room",
                            style: TextStyle(
                                fontFamily: 'Chalet',
                                fontSize: deviceWidth * 0.05,
                                color: whitePrimary,
                                fontWeight: FontWeight.w100,
                                height: deviceHeight * 0.001)),
                      ),
                      SizedBox(height: deviceHeight * 0.008),

                      // room ID textField
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: roomIDController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: whitePrimary,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              hintText: 'Enter room ID to join it',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 174, 173, 173))),
                        ),
                      ),

                      SizedBox(height: deviceHeight * 0.01),

                      // room password textField
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          obscureText: true,
                          controller: roomPasswordController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: whitePrimary,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              hintText:
                                  'Leave blank if the room has no password',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 174, 173, 173))),
                        ),
                      ),

                      SizedBox(height: deviceHeight * 0.016),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          backgroundColor: orangePrimary,
                          child: const Icon(Icons.arrow_forward_ios_rounded,
                              color: whitePrimary),
                          onPressed: () async {
                            try {
                              late JoinRoomRequest joinRoomBody;
                              final passwordText = roomPasswordController.text;
                              if (passwordText.trim().length > 1) {
                                joinRoomBody = JoinRoomRequest(
                                    roomID: roomIDController.text,
                                    roomPassword: roomPasswordController.text);
                              } else {
                                joinRoomBody = JoinRoomRequest(
                                    roomID: roomIDController.text);
                              }

                              await roomService
                                  .joinRoom(joinRoomBody)
                                  .then((response) {
                                if (response[0] == 200) {
                                  // refresh the state of roomProvider
                                  ref.invalidate(roomDataProvider);
                                  ref.read(roomDataProvider);
                                } else {
                                  SnackBar snackBar = CustomSnackbar()
                                      .displaySnacbar(0, response[1]);

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }
                              });
                            } on Exception catch (e) {
                              SnackBar snackBar = CustomSnackbar()
                                  .displaySnacbar(0, e.toString());

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }
                          },
                        ),
                      ),

                      SizedBox(height: deviceHeight * 0.020),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("My rooms",
                            style: TextStyle(
                                fontFamily: 'Chalet',
                                fontSize: deviceWidth * 0.05,
                                color: whitePrimary,
                                fontWeight: FontWeight.w100,
                                height: deviceHeight * 0.001)),
                      ),

                      SizedBox(height: deviceHeight * 0.014),

                      // Display horizontal scroll rooms
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: deviceWidth,
                          child: SizedBox(
                            height: deviceWidth * 0.56,
                            width: deviceWidth * 0.42,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: roomList.length,
                              itemBuilder: (context, index) {
                                return Stack(children: [
                                  Container(
                                    height: deviceWidth * 0.8,
                                    width: deviceWidth * 0.42,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: deviceWidth * 0.4,
                                      width: deviceWidth * 0.42,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: BoxDecoration(
                                          color: orangePrimary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(0, 5),
                                                blurRadius: 10)
                                          ]),
                                      child: Image.asset(
                                          "assets/watchWithMeLogo.png"),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InsideRoomPage(
                                                      room: roomList[index])));
                                    },
                                  ),
                                  Positioned(
                                      bottom: 35,
                                      left: 12,
                                      child: Text(roomList[index].roomName)),
                                  Positioned(
                                      bottom: 15,
                                      left: 12,
                                      child: GestureDetector(
                                        onTap: () {
                                          final uniqueIDRoom =
                                              TextEditingController();
                                          uniqueIDRoom.text =
                                              roomList[index].uniqueID;
                                          Clipboard.setData(ClipboardData(
                                              text: uniqueIDRoom.text));

                                          const snackBar = SnackBar(
                                            content: Text("Copied room ID"),
                                          );

                                          // Find the ScaffoldMessenger in the widget tree
                                          // and use it to show a SnackBar.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        child: Text(
                                            "ID: ${roomList[index].uniqueID}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ))
                                ]);
                              },
                            ),
                          ),
                        ),
                      )
                    ]),
              ));
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
