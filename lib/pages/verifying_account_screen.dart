import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VerifyingAccount extends StatefulWidget {
  const VerifyingAccount({super.key});

  @override
  State<VerifyingAccount> createState() => _VerifyingAccountState();
}

class _VerifyingAccountState extends State<VerifyingAccount> {
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
                color: Color(0xFFDF862D),
                fontWeight: FontWeight.w300,
                height: 1.0
              ),),

              const Text("account",
              style: TextStyle(
                height: 1.0,
                fontFamily: 'Chalet',
                fontSize: 48,
                color: Color(0xFFF6F9F8),
                fontWeight: FontWeight.w300
              ),),

              const SizedBox(height: 143),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LoadingAnimationWidget.discreteCircle(
                  color: const Color(0xFFDF862D),
                  size: 140,
                  secondRingColor: const Color(0xFFF6F9F8),
                  thirdRingColor: const Color(0xFFDF862D)
                ),
            ]),

            const SizedBox(height: 12),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Waiting...",
                style: TextStyle(
                  color: Color(0xFFF6F9F8),
                  fontSize: 24,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Chalet'
                ),)
              ],
            ),

            const SizedBox(height: 92),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("We will send you an e-mail to verify your account ",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  color: Color(0xFFF6F9F8),
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive an email?",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  color: Color(0xFFF6F9F8),
                  fontWeight: FontWeight.bold
                ),),

                TextButton(onPressed: () {},
                 child: const Text(
                  "Request again",
                  style: TextStyle(
                  fontFamily: "Chalet",
                  fontSize: 13,
                  color: Color(0xFFF6F9F8),
                  fontWeight: FontWeight.bold
                ),
                 ))
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}
