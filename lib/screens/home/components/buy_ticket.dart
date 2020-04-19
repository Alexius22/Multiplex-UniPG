// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';
import './seat_checkbox.dart';

class BuyTicket extends StatefulWidget {
  @override
  _State createState() => new _State();
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

class _State extends State<BuyTicket> {
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
              _buildScreen(),
              _buildSeats(),
              _legendColor(),
              /*
              Text("DIM TAB"),
              _dimTab(),
              */
              Text("SELECTION POPUP"),
              _selectPopup(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
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
        padding: EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            "Seleziona il posto",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: CustomPaint(
          size: Size(350, 70),
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
            width: 35,
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
      padding: EdgeInsets.only(left: 40, right: 40),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: checkBoxRows,
      ),
    );
  }

  Widget _legendColor() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildLegendLabel(
              Icons.radio_button_unchecked, Colors.grey, "Disponibile"),
          _buildLegendLabel(Icons.brightness_1, Colors.green, "Selezionato"),
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
          size: 20,
        ),
        SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _selectPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("First"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Second"),
          ),
        ],
        initialValue: 2,
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          print("value:$value");
        },
        icon: Icon(Icons.list),
      );

  Widget _button(String text) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0),
      ),
      //color: pressedButtons[0] ? Colors.deepOrange[900] : Colors.black,
      color: Colors.deepOrange[900],
      splashColor: Colors.deepOrange[300],
      textColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0),
      ),
      onPressed: () {
        //_pressButton(0);
      },
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
