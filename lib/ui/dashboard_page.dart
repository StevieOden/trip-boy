import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/alert_dialog.dart';
import 'package:trip_boy/ui/activity_page.dart';
import 'package:trip_boy/ui/explore/explore_page.dart';
import 'package:trip_boy/ui/home_page.dart';
import 'package:trip_boy/ui/profile_page.dart';
import 'package:trip_boy/ui/upload_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
  int selectedIndex;
  int exploreSelectionIndex;
  DashboardPage(
      {super.key, this.selectedIndex = 0, this.exploreSelectionIndex = 0});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => AlertDialogComponent(
          context: context,
          title: AppLocalizations.of(context)!.close_app_dialog_title,
          content: Text(AppLocalizations.of(context)!.close_app_dialog),
          exitButton: true,
          onPressedYes: null),
    );
    return exitResult ?? false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(
          selectedIndex: widget.selectedIndex,
          selectedTabIndex: widget.exploreSelectionIndex),
      ExplorePage(exploreSelectionIndex: widget.exploreSelectionIndex),
      ActivityPage(),
      UploadPage(),
      ProfilePage()
    ];
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: _widgetOptions.elementAt(widget.selectedIndex),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: SafeArea(
            child: GNav(
              activeColor: ColorValues().primaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: ColorValues().secondaryColor,
              color: Colors.black45,
              tabs: [
                GButton(
                  gap: 5,
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  gap: 5,
                  icon: Icons.explore_outlined,
                  text: 'Explore',
                ),
                GButton(
                  gap: 5,
                  icon: Icons.receipt_long,
                  text: 'Activity',
                ),
                GButton(
                  gap: 5,
                  icon: Icons.upload_outlined,
                  text: 'Upload',
                ),
                GButton(
                  gap: 5,
                  icon: Icons.account_circle_outlined,
                  text: 'Profile',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
