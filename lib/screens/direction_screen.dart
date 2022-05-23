import 'package:flutter/material.dart';
import './nav.dart';

class DirectionScreen extends StatefulWidget {
  const DirectionScreen({Key? key}) : super(key: key);
  static const String id = 'direction_screen';

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  String select = 'English';
  List<String> selectList = ['Arabic', 'English'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Image.asset(
                    'assets/images/vector.png',
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.only(top: 8.0),
                  child:  Text(
                    'SL-Translator',
                    style: TextStyle(
                      color: Color(0xFF3FBFC0),
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Color(0xFF3FBFC0),
            ),
            child: Column(
              children: <Widget>[
                 const Padding(
                   padding: EdgeInsets.only(top: 25,),
                   child: Text(
                    'Translate Direction',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                ),
                 ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    child: Text(
                      'Sign Language to Text',
                      style: TextStyle(
                        color: Color(0xFF535F77),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50 , right: 50,),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                      isExpanded: true,
                      iconEnabledColor: const Color(0xFF535F77),
                      underline: const SizedBox(),
                      value: select,
                      onChanged: (String? newValue) {
                        setState(() {
                          select = newValue!;
                        });
                      },
                      items: selectList.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: ElevatedButton(
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
                      'Select',
                      style: TextStyle(
                        color: Color(0xFF3FBFC0),
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,MaterialPageRoute(builder: (context) => const  NavBar())
                      );
                    },
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
