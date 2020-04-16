import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cinema_app/widgets/bubble_tab_bar/navbar.dart';

import 'screens/home/home.dart';
import 'screens/tickets/tickets.dart';
import 'screens/profile/profile.dart';
import 'screens/settings/settings.dart';

class BubbleTabBar extends StatefulWidget {
  @override
  _BubbleTabBarState createState() => _BubbleTabBarState();
}

class _BubbleTabBarState extends State<BubbleTabBar> {
  List<NavBarItemData> _navBarItems;
  int _selectedNavIndex = 0;

  List<Widget> _viewsByIndex;

  @override
  void initState() {
    //Create the views which will be mapped to the indices for our nav btns
    _viewsByIndex = <Widget>[
      HomeScreen(),
      TicketScreen(),
      ProfileScreen(),
      SettingScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).highlightColor;

    //Declare some buttons for our tab bar
    _navBarItems = [
      NavBarItemData("Home", OMIcons.home, 110, accentColor),
      NavBarItemData("Biglietti", OMIcons.receipt, 120, accentColor),
      NavBarItemData("Profilo", OMIcons.person, 110, accentColor),
      NavBarItemData("Impostazioni", OMIcons.settings, 150, accentColor),
    ];

    //Create custom navBar, pass in a list of buttons, and listen for tap event
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index
    var contentView =
        _viewsByIndex[min(_selectedNavIndex, _viewsByIndex.length - 1)];
    //Wrap our custom navbar + contentView with the app Scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          //Wrap the current page in an AnimatedSwitcher for an easy cross-fade effect
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            //Pass the current accent color down as a theme, so our overscroll indicator matches the btn color
            child: Theme(
              data: ThemeData(accentColor: accentColor),
              child: contentView,
            ),
          ),
        ),
      ),
      bottomNavigationBar: navBar, //Pass our custom navBar into the scaffold
    );
  }

  void _handleNavBtnTapped(int index) {
    //Save the new index and trigger a rebuild
    setState(() {
      //This will be passed into the NavBar and change it's selected state, also controls the active content page
      _selectedNavIndex = index;
    });
  }

  Widget buildAppBar() {
    Color backgroundColor = Theme.of(context).bottomAppBarColor;
    Color appBarIconsColor = Colors.white70;

    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(Icons.more_horiz, color: appBarIconsColor, size: 28),
        )
      ],
      brightness: Brightness.dark,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          'Cinema App'.toUpperCase(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            color: appBarIconsColor,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            package: 'cinema_app',
          ),
        ),
      ),
    );
  }
}
