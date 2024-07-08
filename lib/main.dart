import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/screens/splash_screen.dart'; 
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neflix clone',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
       textTheme: const TextTheme(
        bodyLarge: TextStyle(color: nWhite,fontSize: 24),
        bodyMedium: TextStyle(color: nWhite, fontSize: 27)
       ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple ).copyWith(
          background:nBlack
        ),
        fontFamily: GoogleFonts.ptSans().fontFamily
      ),
        
    home:const SplashScreen(),
    );
  }
}