import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_with_me/pages/login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // TextFields controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
        width: double.infinity,
        color: const Color(0xFF26243C),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              const SizedBox(height: 72),

              const Text("Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Chalet',
                fontSize: 48,
                fontWeight: FontWeight.w100,
                color: Color(0xFFDF862D),
                height: 1.0
              ),),
          
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              const Text('Already have an account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFF6F9F8))),
          
                TextButton(
                  onPressed: () {
                    // take you to login page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                    child: const Text(
                  'Sign In!',
                  style: TextStyle(
                      color: Color(0xFFF6F9F8), fontWeight: FontWeight.bold)
                ))
              ],
            ),
          
            const SizedBox(height: 65),
          
            const Text("Your e-mail",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Color(0xFFF6F9F8)
            ),),
          
            const SizedBox(height: 12),
          
            // email textField  
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF6F9F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Enter your e-mail',
                  hintStyle: const TextStyle(
                    color:Color.fromARGB(255, 174, 173, 173)
                  )
                ),
              ),
            ),
          
            const SizedBox(height: 12),
          
            const Text("Your password",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Color(0xFFF6F9F8)
            ),),
          
            const SizedBox(height: 12),
          
            // password textField  
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF6F9F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                    color:Color.fromARGB(255, 174, 173, 173)
                  )
                ),
              ),
            ),
          
            const SizedBox(height: 12),
          
            const Text("Confirm your password",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Color(0xFFF6F9F8)
            ),),
          
            const SizedBox(height: 12),
          
            // confirm password textField  
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF6F9F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Confirm your password',
                  hintStyle: const TextStyle(
                    color:Color.fromARGB(255, 174, 173, 173)
                  )
                ),
              ),
            ),
          
            const SizedBox(height: 88),

            TextButton(onPressed: () {

            },
            style: TextButton.styleFrom(backgroundColor: const Color(0xFFDF862D)),
             child: 
            const SizedBox(
              height: 38,
              width: 288,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF6F9F8),
                      fontSize: 16,
              
                    ),
                  )
                ],
              ),
            )),

            // OR
            Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      height: 36,
                    )),
              ),
              const Text("Or", 
              style: TextStyle(
                color: Color(0xFFA1A0A0),
                fontFamily: 'Chalet'
                )),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: const Divider(
                      height: 36,
                    )),
              ),
            ]),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFDF862D))),
                  onPressed:() {},
                  icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.white,),
                  label: const Text(
                    "Facebook",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    )),

                const SizedBox(width: 20),

                TextButton.icon(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFDF862D))),
                  onPressed:() {},
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white,),
                  label: const Text(
                    "Google",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    ))
              ],
            ),

            const SizedBox(height: 36)

            ],
          ),
        ),
      ),
    );
  }
}
