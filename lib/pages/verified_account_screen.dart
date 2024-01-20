import 'package:flutter/material.dart';

class VerifiedAccount extends StatefulWidget {
  const VerifiedAccount({super.key});

  @override
  State<VerifiedAccount> createState() => _VerifiedAccountState();
}

class _VerifiedAccountState extends State<VerifiedAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
        height: double.infinity,
        width: double.infinity,
        color:const Color(0xFF26243C),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 72),
              
              const Text("Verify your",
              style: TextStyle(
                fontFamily: 'Chalet',
                fontSize: 48,
                color: Color(0xFFF6F9F8),
                fontWeight: FontWeight.w300,
                height: 1.0
              ),),

              const Text("account",
              style: TextStyle(
                height: 1.0,
                fontFamily: 'Chalet',
                fontSize: 48,
                color: Color(0xFFDF862D),
                fontWeight: FontWeight.w300
              ),),

              const SizedBox(height: 143),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset('assets/doneIcon.png')
            ]),

              const SizedBox(height: 130),

              TextButton(onPressed: () {

            }, 
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFFDF862D))),
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
            ))

            ],
          ),
        ),
      ),
    );
  }
}
