import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trip_boy/ui/activity_page.dart';
import 'package:trip_boy/ui/explore_page.dart';
import 'package:trip_boy/ui/home_page.dart';
import 'package:trip_boy/ui/profile_page.dart';
import 'package:trip_boy/ui/upload_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ExplorePage(),
    ActivityPage(),
    UploadPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: SafeArea(
          child: GNav(
            activeColor: Color.fromRGBO(111, 56, 197, 1),
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Color.fromRGBO(228, 211, 255, 1),
            color: Colors.black45,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.explore_outlined,
                text: 'Explore',
              ),
              GButton(
                icon: Icons.receipt_long,
                text: 'Activity',
              ),
              GButton(
                icon: Icons.upload_outlined,
                text: 'Upload',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container();
  }
}
