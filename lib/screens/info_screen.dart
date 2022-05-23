import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);
  static const String id = 'info_screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Welcome !"),
        backgroundColor: const Color(0xFF3FBFC0),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: Text(
              'What About Our App !',
              style: TextStyle(
                color: Color(0xFF2D2F32),
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 25 , right: 25),
            child: Text(
              'Our App is easy to use, free, no ads, no permissions required!'
              "you can't revoke any already granted permission with this app."
              'So, this app would be useful for: '
                   '      deaf people; to make communication with normal people in Arabic and english'
              'others; to easily view permissions of a specific app or apps which use a specific permission.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color(0xFF2D2F32),
                fontSize: 17,
                height:2.5,
                letterSpacing: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
