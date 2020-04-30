import 'dart:math';
import 'package:flutter/material.dart';

import 'package:cinema_app/widgets/bubble_tab_bar/navbar.dart';
import 'package:cinema_app/widgets/bubble_tab_bar/navbar_item_data.dart';

class BubbleTabBar extends StatefulWidget {
  final List<NavBarItemData> items;
  final List<String> cities;
  const BubbleTabBar({this.items, this.cities});

  @override
  _BubbleTabBarState createState() => _BubbleTabBarState();
}

class _BubbleTabBarState extends State<BubbleTabBar> {
  // Working variables
  int _selectedNavIndex;
  String _dropdownValue;

  @override
  void initState() {
    _selectedNavIndex = 2;
    _dropdownValue = widget.cities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Create custom navBar, pass in a list of buttons, and listen for tap event
    var navBar = NavBar(
      items: widget.items,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index
    var contentView =
        widget.items[min(_selectedNavIndex, widget.items.length - 1)].widget;

    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            child: contentView,
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
    return AppBar(
      actions: <Widget>[
        Align(alignment: Alignment.centerRight, child: _buildDropDownMenu()),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 26),
            child: Image.asset(
              'images/logo.png',
              height: MediaQuery.of(context).size.height / 27,
            ),
          ),
          Text(
            'Multiplex UniPG'.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 42,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildDropDownMenu() {
    return DropdownButton<String>(
      value: _dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: MediaQuery.of(context).size.height / 26,
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        setState(() {
          _dropdownValue = newValue;
        });
      },
      items: widget.cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
