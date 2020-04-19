// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

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
    canvas.drawArc(new Rect.fromLTWH(0.0, 0.0, size.width, size.height/2.5),
  10, 2, false, paint);
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
            ],
          ),
          _buildBackButton(context),
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
      child: CustomPaint(
        size: Size(300, 300),
        painter: MyPainter(),
      ),
    );
  }

  Widget _buildSeats({rows: 5, columns: 6}) {
    List<Widget> checkBoxColumns = [];
    for(int i=0; i<columns; i++) {
      checkBoxColumns.add(_buildCheckBox());
    }

    List<TableRow> checkBoxRows = [];
    for(int i=0; i<rows; i++) {
      checkBoxRows.add(TableRow(children: checkBoxColumns));
    }

    return Table(
      children: checkBoxRows,
    );
  }

  Widget _buildCheckBoxDisabled() {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        value: true,
        onChanged: null,
        checkColor: Colors.grey[800],
      ),
    );
  }

  bool _isChecked = false;

  Widget _buildCheckBox() {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        value: _isChecked,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
          });
        },
        activeColor: Colors.deepOrange[900],
      ),
    );
  }
}
