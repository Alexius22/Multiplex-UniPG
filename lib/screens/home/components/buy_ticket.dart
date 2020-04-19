// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cinema_app/data/films.dart';
import './seat_checkbox.dart';

class BuyTicket extends StatefulWidget {
  final Film film;

  BuyTicket({
    this.film,
  });

  @override
  _State createState() => new _State();
}

class _State extends State<BuyTicket> {
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
              _buildScreen(),
              _buildSeats(),
              _legendColor(),
              /*
              Text("DIM TAB"),
              _dimTab(),
              */
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _datePicker(),
                  _timePicker(),
                ],
              ),
              Text("Vuoi includere uno snack?", style: TextStyle(fontSize: 20)),
              _foodSelection("Pop-corn"),
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
        padding: EdgeInsets.only(top: 13),
        child: Center(
          child: Text(
            "Seleziona il posto",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
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

  Widget _datePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 4),
            Text(
              "Giorno",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            MaterialButton(
              padding: EdgeInsets.all(3.0),
              height: 0.0,
              minWidth: 10,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashColor: Colors.deepOrange[300],
              textColor: Colors.white,
              child: Text(
                _selectedDate,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: _selectDate,
            ),
            Icon(Icons.keyboard_arrow_left),
          ],
        ),
      ],
    );
  }

  Widget _foodSelection(text) {
    return SwitchListTile(
      title: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height / 40,
          )),
      subtitle: Text("Piccolo: € 2.00",
          style: TextStyle(
            color: Colors.grey.shade400,
          )),
      value: false,
      onChanged: (val) {},
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
            SizedBox(width: 4),
            Text(
              "Orario",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
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
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "€ 12.40",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buyButton() {
    return Container(
      height: 50,
      width: 180,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.deepOrange[900],
        splashColor: Colors.deepOrange[300],
        textColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.arrow_forward_ios,
              size: 22,
            ),
            Text(
              "Acquista",
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
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
