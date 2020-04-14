import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cinema_app/widgets/bubble_tab_bar/navbar.dart';

import 'screens/dashboard.dart';
import 'screens/tickets.dart';
import 'screens/profile.dart';
import 'screens/settings.dart';


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
    //Declare some buttons for our tab bar
    _navBarItems = [
      NavBarItemData("Dashboard", OMIcons.home, 135, Color(0xff01b87d)),
      NavBarItemData("Biglietti", OMIcons.tv, 120, Color(0xff594ccf)),
      NavBarItemData("Profilo", OMIcons.person, 110, Color(0xff09a8d9)),
      NavBarItemData("Impostazioni", OMIcons.settingsApplications, 150, Color(0xffcf4c7a)),
    ];

    //Create the views which will be mapped to the indices for our nav btns
    _viewsByIndex = <Widget>[
      Dashboard(),
      Dashboard(),
      Dashboard(),
      Dashboard(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = _navBarItems[_selectedNavIndex].selectedColor;

    //Create custom navBar, pass in a list of buttons, and listen for tap event
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index
    var contentView = _viewsByIndex[min(_selectedNavIndex, _viewsByIndex.length - 1)];
    //Wrap our custom navbar + contentView with the app Scaffold
    return Scaffold(
      backgroundColor: Color(0xffE6E6E6),
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
}
