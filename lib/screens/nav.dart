import 'package:flutter/material.dart';
import './home_screen.dart';
import './information_screen.dart';
import './direction_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  List <Widget> _screensOptions = <Widget>[
    HomeScreen(),
    InformationScreen(),
    DirectionScreen(),
  ];

  void _onItemTap(int index){
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }
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
      body: Center(child:_screensOptions.elementAt(_selectedIndex) ,),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: "Select",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF3FBFC0),
        onTap:_onItemTap,
      ),
    );
  }
}
