// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cinema_app/data/films.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/button_icon.dart';
import 'components/seat_checkbox.dart';
import 'components/food_selection.dart';

// Next page
import 'package:cinema_app/transitions/slide_left_route.dart';
import 'components/checkout.dart';

class BuyTicket extends StatefulWidget {
  final Film film;

  BuyTicket({
    this.film,
  });

  @override
  _State createState() => new _State();
}

class _State extends State<BuyTicket> with SingleTickerProviderStateMixin {
  // Configuration variables
  List<String> _shotTypologies = ['2D', '3D'];
  DateTime _minDate = DateTime.now();
  DateTime _maxDate = DateTime.now().add(new Duration(days: 13));
  List<String> _hours;

  // Prices
  double _totalCost = 0.0;
  Map _shotTypologyPrices = {'2D': 3.5, '3D': 5.0};

  // Data selection
  TabController _shotTyplogyPicked;
  String _timePicked;
  String _datePicked = 'GG/MM';
  List<Point> _seatsPicked = [];

  @override
  void initState() {
    // Get informations about the film
    _hours = widget.film.hours;

    // Initialize pickers
    _shotTyplogyPicked = TabController(
        vsync: this, initialIndex: 0, length: _shotTypologies.length);
    _shotTyplogyPicked.addListener(() {
      if (_shotTyplogyPicked.indexIsChanging) {
        // TODO: Cambiare tipologia di riproduzione dovrebbe cambiare anche date e orari disponibili
        setState(() {});
      }
    });
    _timePicked = _hours[0];
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // Update widgets
    super.setState(fn);

    // Calculate total price
    final String _shotSelected = _shotTypologies[_shotTyplogyPicked.index];
    _totalCost = _shotTypologyPrices[_shotSelected] * _seatsPicked.length;
  }

  @override
  void dispose() {
    _shotTyplogyPicked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Config
    final TextStyle _secondaryStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
      fontSize: MediaQuery.of(context).size.height / 40,
    );

    return Scaffold(
      appBar: GoBackAppBar("Il tuo ordine").build(context),
      body: Stack(
        children: <Widget>[
          // Footer
          _footer(),
          // Everything else
          Container(
            height: 3 / 4 * MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildShotTypology(_secondaryStyle),
                        _datePicker(_secondaryStyle),
                        _timePicker(_secondaryStyle),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildScreen(),
                  SizedBox(height: 5),
                  _buildSeats(),
                  SizedBox(height: 10),
                  _buildLegend(),
                  SizedBox(height: 15),
                  _buildSeatsSummary(_secondaryStyle),
                  SizedBox(height: 20),
                  _buildOptionalSnacks(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen() {
    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width / 1.2,
        MediaQuery.of(context).size.height / 15,
      ),
      painter: ScreenPainter(
        angleLimiter: 0.2,
        strokeWidth: 1.3,
        strokeColor: Theme.of(context).textTheme.title.color,
        blurValue: 6.0,
        fillColor: Colors.deepOrange.withOpacity(0.5),
      ),
    );
  }

  Widget _buildSeats({rows: 6, columns: 8, height: 250.0}) {
    List<Row> checkBoxRows = [];
    Random _rand = Random();
    final bool _isDarkThemeEnabled =
        Theme.of(context).backgroundColor == Colors.black;

    for (int i = 0; i < rows; i++) {
      List<Widget> checkBoxRow = [];
      for (int j = 0; j < columns; j++) {
        checkBoxRow.add(
          SeatCheckBox(
            width: MediaQuery.of(context).size.width / 12,
            backgroundColor: _isDarkThemeEnabled ? Colors.black : Colors.white,
            backgroundColorChecked: Colors.deepOrange[900],
            borderColorChecked: Colors.deepOrange,
            highlightColor: _isDarkThemeEnabled
                ? Colors.white24
                : Colors.deepOrange[500].withOpacity(0.5),
            splashColor:
                _isDarkThemeEnabled ? Colors.white38 : Colors.deepOrange[900],
            disabled: _rand.nextBool(),
            onCheckChange: (status) {
              setState(() {
                final int x = rows - i;
                final int y = j + 1;
                if (status)
                  _seatsPicked.add(Point(x, y));
                else
                  _seatsPicked.remove(Point(x, y));
              });
            },
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
    return Padding(
      padding: EdgeInsets.only(
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
        SizedBox(width: 3),
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

  Widget _buildSeatsSummary(_secondaryStyle) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 10,
        right: MediaQuery.of(context).size.width / 10,
      ),
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
          // Animation WIP, to be fixed
          Container(
            width: MediaQuery.of(context).size.width / 1.7,
            alignment: Alignment.centerLeft,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: Text(
                _seatsPicked.isEmpty == true ? "..." : "${_formatSeats()}",
                style: _secondaryStyle,
                key: ValueKey<int>(_seatsPicked.length),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSeats() {
    String _out = "";
    for (Point el in _seatsPicked) {
      String _row = String.fromCharCode(65 + el.x);
      _out += "$_row${el.y}, ";
    }
    // Remove comma and return
    return _out.substring(0, _out.length - 2);
  }

  Widget _shotdDateTimePicker(String title, IconData icon, Widget bottomChild) {
    return Container(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: MediaQuery.of(context).size.height / 50,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          bottomChild,
        ],
      ),
    );
  }

  Widget _buildShotTypology(_secondaryStyle) {
    return _shotdDateTimePicker(
      "Tipologia",
      Icons.live_tv,
      Column(
        children: <Widget>[
          Container(
            width: 120,
            height: 32,
            child: TabBar(
              controller: _shotTyplogyPicked,
              tabs: _shotTypologies
                  .map(
                    (typ) => Tab(
                      text: typ,
                    ),
                  )
                  .toList(),
              labelColor: _secondaryStyle.color,
              unselectedLabelColor:
                  Theme.of(context).textTheme.title.color.withOpacity(0.3),
              labelStyle: _secondaryStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePicker(_secondaryStyle) {
    // Internal function for calendar
    Future _selectDate() async {
      DateTime _picked = await showDatePicker(
        context: context,
        initialDate: this._minDate,
        firstDate: this._minDate,
        // This should be edited with the effective duration
        lastDate: this._maxDate,
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
      if (_picked != null) {
        setState(() => _datePicked =
            _picked.day.toString() + "/" + _picked.month.toString());
      }
    }

    return _shotdDateTimePicker(
      "Giorno",
      Icons.calendar_today,
      FlatButton(
        padding: EdgeInsets.only(left: 8.0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        highlightColor:
            Theme.of(context).textTheme.title.color.withOpacity(0.1),
        splashColor: Theme.of(context).textTheme.title.color.withOpacity(0.2),
        child: Row(
          children: <Widget>[
            Text(
              _datePicked,
              style: _secondaryStyle,
            ),
            Icon(Icons.keyboard_arrow_left),
          ],
        ),
        onPressed: _selectDate,
      ),
    );
  }

  Widget _timePicker(_secondaryStyle) {
    return _shotdDateTimePicker(
      "Orario",
      Icons.schedule,
      Padding(
        padding: EdgeInsets.only(bottom: 9.0),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isDense: true,
            value: _timePicked,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 22,
            underline: Container(
              padding: EdgeInsets.all(0.0),
              height: 0,
            ),
            style: _secondaryStyle,
            onChanged: (String newValue) {
              setState(() {
                _timePicked = newValue;
              });
            },
            items: _hours.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionalSnacks() {
    return ExpansionTile(
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
        FoodSelection(title: "Menù Nachos", prices: [4.0, 5.0, 6.0]),
        FoodSelection(title: "Menù PopCorn", prices: [4.0, 5.0, 6.0]),
        FoodSelection(title: "Yogurt"),
        FoodSelection(title: "Coca-Cola"),
        FoodSelection(title: "Sprite"),
        FoodSelection(title: "Acqua", prices: [1.5]),
        FoodSelection(title: "Smarties", prices: [1.5]),
        FoodSelection(title: "Twix", prices: [1.5]),
        FoodSelection(title: "Bounty", prices: [1.5]),
        FoodSelection(title: "Mars", prices: [1.5]),
      ],
    );
  }

  Widget _footer() {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(28.0),
          child: Row(
            children: <Widget>[
              Text(
                "Totale:",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: MediaQuery.of(context).size.height / 45,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: 20),
              Text(
                "€ $_totalCost",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 31,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(20.0),
          child: ButtonWithIcon(
            width: 160,
            text: "Riepilogo",
            icon: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.push(
                context,
                SlideLeftRoute(
                  page: Checkout(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ScreenPainter extends CustomPainter {
  final double angleLimiter;
  final double strokeWidth;
  final Color strokeColor;
  final double blurValue;
  final Color fillColor;

  ScreenPainter({
    this.angleLimiter,
    this.strokeWidth,
    this.strokeColor,
    this.blurValue,
    this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height * 2),
      pi + angleLimiter,
      pi - angleLimiter * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..isAntiAlias = true
        ..color = strokeColor,
    );
    canvas.drawArc(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height * 2),
      pi + angleLimiter,
      pi - angleLimiter * 2,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurValue)
        ..isAntiAlias = true
        ..color = fillColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
