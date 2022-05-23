import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/welcome_screen.dart';
import './screens/direction_screen.dart';
import './screens/information_screen.dart';
import './screens/info_screen.dart';
import './screens/home_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const FinalProject());
}

List<CameraDescription>? cameras;



class FinalProject extends StatelessWidget {
  const FinalProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),

      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/welcome.png',
        ),
        nextScreen: const WelcomeScreen(),
        duration: 3000,
        backgroundColor: const Color(0xFF3FBFC0),
        splashTransition: SplashTransition.rotationTransition,
      ),
      routes: {
        SplashScreen.id : (context) => const SplashScreen(),
        WelcomeScreen.id : (context) => const WelcomeScreen(),
        DirectionScreen.id : (context) => const DirectionScreen(),
         HomeScreen.id : (context) =>  HomeScreen(),
        InformationScreen.id : (context) => const InformationScreen(),
        InfoScreen.id : (context) => const InfoScreen(),


      },

    );
  }
}

