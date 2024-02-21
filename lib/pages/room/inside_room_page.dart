import 'package:flutter/material.dart';
//import 'package:watch_with_me/components/blurry_dialog_with_thumbnail_image.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/pages/room/test_page.dart';
import 'package:watch_with_me/utils/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InsideRoomPage extends StatefulWidget {
  const InsideRoomPage(
      {Key? key,
      required this.room,
      required this.deviceHeight,
      required this.deviceWidth})
      : super(key: key);
  final RoomModelResponse room;
  final double deviceHeight;
  final double deviceWidth;

  @override
  State<InsideRoomPage> createState() => _InsideRoomPageState();
}

class _InsideRoomPageState extends State<InsideRoomPage> {
  // late YoutubePlayerController youtubePlayerController;
  final _youtubeLinkController = TextEditingController();
  final List<String> _messages = [];
  late WebSocketChannel _channel;

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      _channel.sink.add(message);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        iconSize: widget.deviceWidth * 0.09,
                        color: orangePrimary)
                  ],
                ),

                SizedBox(height: widget.deviceHeight * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.room.roomName,
                        style: TextStyle(
                            fontSize: widget.deviceWidth * 0.08,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Chalet",
                            color: orangePrimary))
                  ],
                ),
                // TODO: Display this textField if the room owner ID matches the current suer ID
                SizedBox(
                  height: widget.deviceHeight * 0.04,
                  //width: widget.deviceWidth,
                  child: TextField(
                      controller: _youtubeLinkController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16.0),
                        filled: true,
                        fillColor: whitePrimary,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search_rounded,
                            color: orangePrimary,
                          ),
                          onPressed: () {},
                        ),
                        hintStyle:
                            TextStyle(fontSize: widget.deviceWidth * 0.03),
                        hintText: 'Paste link and press button',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(82),
                        ),
                      )),
                ),

                SizedBox(height: widget.deviceHeight * 0.01),

                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(room: widget.room)));
                    },
                    child: Text(
                      "Chat",
                      style: TextStyle(color: whitePrimary),
                    ))

                // Chat button, to be used - TODO
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: FloatingActionButton.small(
                //       onPressed: () {},
                //       backgroundColor: orangePrimary,
                //       shape: const CircleBorder(),
                //       child: const Icon(Icons.bubble_chart_outlined,
                //           color: whitePrimary)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();

  //   const initURL = "https://www.youtube.com/watch?v=6IKhXXFFOuw";
  //   youtubePlayerController = YoutubePlayerController(
  //       initialVideoId: YoutubePlayer.convertUrlToId(initURL)!,
  //       flags: const YoutubePlayerFlags(isLive: true, autoPlay: false));
  // }

  // @override
  // void deactivate() {
  //   youtubePlayerController.pause();
  //   super.deactivate();
  // }

  // @override
  // void dispose() async {
  //   youtubePlayerController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) => YoutubePlayerBuilder(
  //       player: YoutubePlayer(
  //         controller: youtubePlayerController,
  //       ),
  //       builder: (context, player) => Scaffold(
  //         backgroundColor: bluePrimary,
  //         body: SafeArea(
  //           child: SingleChildScrollView(
  //             child: Container(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           icon: const Icon(Icons.arrow_back),
  //                           iconSize: widget.deviceWidth * 0.09,
  //                           color: orangePrimary)
  //                     ],
  //                   ),

  //                   SizedBox(height: widget.deviceHeight * 0.03),

  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(widget.room.roomName,
  //                           style: TextStyle(
  //                               fontSize: widget.deviceWidth * 0.08,
  //                               fontWeight: FontWeight.w300,
  //                               fontFamily: "Chalet",
  //                               color: orangePrimary))
  //                     ],
  //                   ),
  //                   // TODO: Display this textField if the room owner ID matches the current suer ID
  //                   SizedBox(
  //                     height: widget.deviceHeight * 0.04,
  //                     //width: widget.deviceWidth,
  //                     child: TextField(
  //                         controller: _youtubeLinkController,
  //                         decoration: InputDecoration(
  //                           contentPadding: const EdgeInsets.all(16.0),
  //                           filled: true,
  //                           fillColor: whitePrimary,
  //                           suffixIcon: IconButton(
  //                             icon: const Icon(
  //                               Icons.search_rounded,
  //                               color: orangePrimary,
  //                             ),
  //                             onPressed: () {
  //                               if (_youtubeLinkController.text.isNotEmpty) {
  //                                 _confirmPlayingVideo(
  //                                     context, _youtubeLinkController.text);
  //                               }
  //                             },
  //                           ),
  //                           hintStyle:
  //                               TextStyle(fontSize: widget.deviceWidth * 0.03),
  //                           hintText: 'Paste link and press button',
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(82),
  //                           ),
  //                         )),
  //                   ),

  //                   SizedBox(height: widget.deviceHeight * 0.01),

  //                   //player,

  //                   // Chat button, to be used - TODO
  //                   // Align(
  //                   //   alignment: Alignment.bottomRight,
  //                   //   child: FloatingActionButton.small(
  //                   //       onPressed: () {},
  //                   //       backgroundColor: orangePrimary,
  //                   //       shape: const CircleBorder(),
  //                   //       child: const Icon(Icons.bubble_chart_outlined,
  //                   //           color: whitePrimary)),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  // _getThumbnail(String videoURL) {
  //   final thumbnail = YoutubePlayer.getThumbnail(
  //       videoId: YoutubePlayer.convertUrlToId(videoURL)!);
  //   return Image.network(thumbnail);
  // }

  // _confirmPlayingVideo(BuildContext context, String videoURL) {
  //   continueCallBack() {
  //     youtubePlayerController
  //         .load(YoutubePlayer.convertUrlToId(_youtubeLinkController.text)!);
  //     _youtubeLinkController.text = "";
  //   }

  //   BlurryDialogWithThumbnailImage alert = BlurryDialogWithThumbnailImage(
  //       title: "PLAY THIS VIDEO",
  //       content: _getThumbnail(videoURL),
  //       continueCallBack: continueCallBack);

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
