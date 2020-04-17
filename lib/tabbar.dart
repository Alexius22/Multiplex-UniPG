import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cinema_app/widgets/bubble_tab_bar/navbar.dart';

import 'screens/home/home.dart';
import 'screens/tickets/tickets.dart';
import 'screens/profile/profile.dart';
import 'screens/settings/settings.dart';

import 'package:cinema_app/data/cities.dart';

class BubbleTabBar extends StatefulWidget {
  @override
  _BubbleTabBarState createState() => _BubbleTabBarState();
}

class _BubbleTabBarState extends State<BubbleTabBar> {
  // Extract cities data
  List<String> _cities = [];
  String dropdownValue;

  // Working variables
  List<NavBarItemData> _navBarItems;
  int _selectedNavIndex = 0;
  List<Widget> _viewsByIndex;

  @override
  void initState() {
    // Extract cities data
    final _citiesData = CitiesData();
    dropdownValue = _citiesData.getCity(0).name; // Defaults to 'Perugia'
    _citiesData.getAll.forEach((City city) {
      _cities.add(city.name);
    });

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
      NavBarItemData("Home", OMIcons.home, 120, accentColor),
      NavBarItemData("Biglietti", OMIcons.receipt, 130, accentColor),
      NavBarItemData("Profilo", OMIcons.person, 120, accentColor),
      NavBarItemData("Impostazioni", OMIcons.settings, 180, accentColor),
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
    Color backgroundColor = Colors.black;
    Color appBarIconsColor = Colors.white70;

    return AppBar(
      actions: <Widget>[
        Align(alignment: Alignment.centerRight, child: _buildDropDownMenu()),
      ],
      brightness: Brightness.dark,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          'Multiplex UniPG'.toUpperCase(),
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

  _buildDropDownMenu() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      style: TextStyle(
        fontFamily: 'OpenSans',
        color: Colors.white70,
      ),
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: _cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
