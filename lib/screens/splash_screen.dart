import 'package:flutter/material.dart';
import './welcome_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), (){});
    Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context) => const WelcomeScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3FBFC0),
      body: Image.asset(
        'assets/images/welcome.png',
      ),
    );
  }
}
