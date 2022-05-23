import 'package:flutter/material.dart';
import './info_screen.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);
  static const String id = 'information_screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   shape:
      //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //   title: const Text("Welcome !"),
      //   backgroundColor: const Color(0xFF3FBFC0),
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 35, left: 25),
            child: Text(
              'What is American Sign Language?',
              style: TextStyle(
                color: Color(0xFF2D2F32),
                fontSize: 25,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 25 , right: 25),
            child: Text(
              'American Sign Language (ASL) is a complete,'
                  'natural language that has the same linguistic properties as spoken languages with grammar that differs from English. ASL is expressed by movements of the hands and face.'
                  'It is the primary language of many North Americans who are deaf and hard of hearing'
                  'and is used by some hearing people as well.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color(0xFF2D2F32),
                fontSize: 22,
                height: 1.1,
                letterSpacing: 0.1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (context) => const InfoScreen())
                  );
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF2D2F32),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
