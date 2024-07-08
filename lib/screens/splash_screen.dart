import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/widgets/%20bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4) ,(){
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const BottomNavbar() ));
    });
    // super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset('assets/netflix.json'),
    );
  }
} 