import 'package:flutter/material.dart';
import './direction_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3FBFC0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40,),
            child: Image.asset(
              'assets/images/splashscreen.png',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              SizedBox(
                height: 60,
              ),
               Padding(
                 padding: EdgeInsets.only(left: 15,bottom: 8,),
                 child: Text(
                  'SL-Translator',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
              ),
               ),
              Padding(
                padding: EdgeInsets.only(left: 15,),
                child: Text(
                  'Are you ready for an easier communication with us',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 30),
              primary: Colors.white,
              elevation: 0,
            ),
            child: const Text(
              'Start',
              style: TextStyle(
                  color: Color(0xFF3FBFC0),
                fontSize: 25,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context) => const DirectionScreen())
              );
            },
          ),
          Container(
            width: 200,
            height: 10,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
