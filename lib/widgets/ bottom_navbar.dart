
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/more_screen.dart';
import 'package:netflix_clone/screens/search_screen.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color:nBlack,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
               Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
               Tab(
                icon: Icon(Icons.photo_library_outlined),
                text: "New & Hot",
              ),
            ],
            indicatorColor:nTransparent,
            labelColor: nWhite,
            unselectedLabelColor:nGray,
          ),
  
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen()
          ],),
      ),
    );
  
  }
}
