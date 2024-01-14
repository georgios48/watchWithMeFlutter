import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFDF862D),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(36, 72, 0, 0),
            child: 
            Text("Unlimited \nStreaming",
            style: TextStyle(fontFamily: 'Chalet', fontSize: 40, height: 1.0),
            )),

            const SizedBox(height: 128),

            const Padding(padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
            child: Text("Watch", 
            style: TextStyle(
              fontFamily: 'Chalet', 
              fontSize: 64, 
              color: Color(0xFFF6F9F8), 
              fontWeight: FontWeight.w100,
              height: 1.0
              )
              ),),
            
            const Padding(padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
            child: Text("With",
              style: TextStyle(
              fontFamily: 'Chalet', 
              fontSize: 64, 
              color: Color(0xFF26243C), 
              fontWeight: FontWeight.w100,
              height: 1.0
              )
            ),
            ),
            
            const Padding(padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
            child: Text("Me",
            style: TextStyle(
              fontFamily: 'Chalet', 
              fontSize: 64, 
              color: Color(0xFFF6F9F8), 
              fontWeight: FontWeight.w100,
              height: 1.0
              )
            ),
            ),
            
            const SizedBox(height: 140),

            Padding(padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
            child: TextButton(onPressed: () {
              // take you to the login screen
            }, 
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF26243C))),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Get Started",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF6F9F8)
                ),)
              ],
            ))),

            const SizedBox(height: 15),

             Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            const Text('Don\'t have an account?',
                    style: TextStyle(color: Color(0xFFF6F9F8))),

              TextButton(
                onPressed: () {
                  // take you to register page
                },
                  child: const Text(
                'Sign Up!',
                style: TextStyle(
                    color: Color(0xFFF6F9F8), fontWeight: FontWeight.bold),
              ))
            ],
          ),
          ],
        )),
    );
  }
}