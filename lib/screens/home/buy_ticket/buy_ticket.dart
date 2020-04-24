// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cinema_app/data/films.dart';
import 'package:cinema_app/transitions/slide_left_route.dart';
import 'components/seat_checkbox.dart';
import 'components/food_selection.dart';
import 'components/checkout.dart';

class BuyTicket extends StatefulWidget {
  final Film film;

  BuyTicket({
    this.film,
  });

  @override
  _State createState() => new _State();
}

class _State extends State<BuyTicket> {
  void _onCheckoutPressed() {
    Navigator.push(context, SlideLeftRoute(page: Checkout()));
  }

  @override
  // Config
  Color selectionColor = Colors.deepOrange;
  Color mainTextColor = Colors.white;
  Color secondaryTextColor = Colors.white;

  // Working variable
  String _timePicked;
  List<String> _hoursChoice;

  String _selectedDate = 'GG/MM';
  DateTime minDate = DateTime.now();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: minDate,
      firstDate: minDate,
      lastDate: minDate.add(new Duration(days: 13)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            backgroundColor: Colors.grey[800],
            dialogBackgroundColor: Colors.grey[900],
            accentColor: Colors.grey[700],
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate =
          picked.day.toString() + "/" + picked.month.toString());
    }
  }

  @override
  void initState() {
    _hoursChoice = widget.film.hours;
    _timePicked = _hoursChoice[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  _buildBackButton(context),
                  _buildHead(),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _buildScreen(),
                      _buildSeats(),
                      _buildLegend(),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      _buildSeatsSummary(),
                      SizedBox(height: MediaQuery.of(context).size.height / 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _datePicker(),
                          _timePicker(),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      ExpansionTile(
                        title: Text(
                          "Vuoi includere uno snack?",
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                        children: <Widget>[
                          FoodSelection(title: "Pop-corn"),
                          FoodSelection(title: "Patatine"),
                          FoodSelection(title: "Caramelle"),
                          FoodSelection(title: "Nachos"),
                          FoodSelection(title: "Hot Dog"),
                          FoodSelection(
                              title: "Menù Nachos", prices: [4.0, 5.0, 6.0]),
                          FoodSelection(
                              title: "Menù PopCorn", prices: [4.0, 5.0, 6.0]),
                          FoodSelection(title: "Yogurt"),
                          FoodSelection(title: "Coca-Cola"),
                          FoodSelection(title: "Sprite"),
                          FoodSelection(title: "Acqua", prices: [1.5]),
                          FoodSelection(title: "Smarties", prices: [1.5]),
                          FoodSelection(title: "Twix", prices: [1.5]),
                          FoodSelection(title: "Bounty", prices: [1.5]),
                          FoodSelection(title: "Mars", prices: [1.5]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Footer
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _totalPrize(),
                _buyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 40,
            top: MediaQuery.of(context).size.height / 80),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: MediaQuery.of(context).size.height / 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildHead() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 60),
        child: Center(
          child: Text(
            "Il tuo ordine",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 27,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 52),
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width / 1.2,
              MediaQuery.of(context).size.height / 11),
          painter: MyPainter(),
        ),
      ),
    );
  }

  Widget _buildSeats({rows: 6, columns: 8, height: 250.0}) {
    List<Row> checkBoxRows = [];
    Random _rand = Random();

    for (int i = 0; i < rows; i++) {
      List<Widget> checkBoxRow = [];
      for (int j = 0; j < columns; j++) {
        checkBoxRow.add(
          SeatCheckBox(
            width: MediaQuery.of(context).size.width / 12,
            backgroundColorChecked: Colors.deepOrange[900],
            borderColorChecked: Colors.deepOrange,
            disabled: _rand.nextBool(),
          ),
        );
      }
      checkBoxRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: checkBoxRow,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 10),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: checkBoxRows,
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 80,
          left: MediaQuery.of(context).size.width / 14,
          right: MediaQuery.of(context).size.width / 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildLegendLabel(
              Icons.radio_button_unchecked, Colors.grey, "Disponibile"),
          _buildLegendLabel(
              Icons.brightness_1, Colors.deepOrange[800], "Selezionato"),
          _buildLegendLabel(Icons.brightness_1, Colors.grey, "Riservato"),
        ],
      ),
    );
  }

  Widget _buildLegendLabel(icon, color, text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: MediaQuery.of(context).size.height / 40,
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 120),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height / 52,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSeatsSummary() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 10),
      child: Row(
        children: <Widget>[
          Text(
            "Posti:",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).size.height / 45,
              letterSpacing: 1,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 40),
          Text(
            "A1, B6, H9, C3, G1",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              color: selectionColor,
              fontSize: MediaQuery.of(context).size.height / 40,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: MediaQuery.of(context).size.width / 120),
            Text(
              "Giorno",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: MediaQuery.of(context).size.height / 50,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 160),
        Row(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                padding: EdgeInsets.only(left: 8.0, right: 0.0),
                height: 0.0,
                minWidth: MediaQuery.of(context).size.width / 40,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                highlightColor: Colors.white24,
                splashColor: Colors.white38,
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Text(
                      _selectedDate,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: selectionColor,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_left),
                  ],
                ),
                onPressed: _selectDate,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _timePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.schedule),
            SizedBox(width: MediaQuery.of(context).size.width / 115),
            Text(
              "Orario",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: MediaQuery.of(context).size.height / 50,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 160),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isDense: true,
            value: _timePicked,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            underline: Container(
              padding: EdgeInsets.all(0.0),
              height: 0,
            ),
            style: TextStyle(
              color: selectionColor,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 45,
            ),
            onChanged: (String newValue) {
              setState(() {
                _timePicked = newValue;
              });
            },
            items: _hoursChoice.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _totalPrize() {
    return Row(
      children: <Widget>[
        Text(
          "Totale:",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: MediaQuery.of(context).size.height / 45,
            letterSpacing: 1,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 40),
        Text(
          "€ 12.40",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 31,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buyButton() {
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      width: MediaQuery.of(context).size.width / 2.3,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.deepOrange[900],
          highlightColor: Colors.white24,
          splashColor: Colors.white38,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_forward_ios,
                size: MediaQuery.of(context).size.height / 37,
              ),
              Text(
                "Riepilogo",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          onPressed: (_onCheckoutPressed)),
    );
  }

  Widget _dimTab() {
    return TabBar(
      unselectedLabelColor: Colors.white,
      labelColor: Colors.deepOrange[900],
      tabs: <Widget>[
        Tab(text: "2D"),
        Tab(text: "3D"),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Rect.fromLTWH(-35.0, 10.0, size.width * 1.2, size.height * 1.5),
        10,
        2,
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
