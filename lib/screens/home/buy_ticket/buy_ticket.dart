// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

// Import data structures
import 'package:cinema_app/services/films.dart';
import 'package:cinema_app/services/snacks.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'components/seat_checkbox.dart';
import 'components/snack_selector.dart';

// Utils
import 'package:cinema_app/utils/format.dart';
import 'package:cinema_app/utils/calendar.dart';

// Next page
import 'package:cinema_app/transitions/slide_left_route.dart';
import 'components/checkout.dart';

/*
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
  final List<String> _shotTypologies = ['2D', '3D'];

  DateTime _minDate = DateTime.now();
  DateTime _maxDate = DateTime.now().add(new Duration(days: 13));
  List<DateTime> _unselectableDays = [];

  List<String> _hours;

  List<int> _roomDim = [6, 8]; // Rows, columns
  List<List<bool>> _seatsStatus;

  Map<String, SnackTypology> _snackTypologies = Map.fromIterable(
    SnackData().getAll,
    key: (snack) => snack.label,
  );

  // Prices
  double _totalCost = 0.0;
  Map _shotTypologyPrices = {'2D': 3.5, '3D': 5.0};

  // User choices
  TabController _shotTyplogyPicked;
  DateTime _dateTimePicked;
  List<String> _seatsPicked = [];
  Map<String, Snack> _snacks = {};

  @override
  void initState() {
    // Get informations about the film
    _hours = ["16:30", "18:30", "20:30"];

    // Initialize pickers: shot typology, day, time
    _shotTyplogyPicked = TabController(
        vsync: this, initialIndex: 0, length: _shotTypologies.length);
    _shotTyplogyPicked.addListener(() {
      if (_shotTyplogyPicked.indexIsChanging) {
        setState(() {
          _unselectableDays = getDaysForShot(
            widget.film,
            _shotTypologies[_shotTyplogyPicked.index],
          );
          _dateTimePicked = null;
          _seatsPicked = [];
        });
      }
    });

    _unselectableDays = getDaysForShot(
      widget.film,
      _shotTypologies[_shotTyplogyPicked.index],
    );

    // Initialize pickers: seats status
    _seatsStatus = List<List<bool>>.generate(_roomDim[0],
        (i) => List<bool>.filled(_roomDim[1], true, growable: false));
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // Update widgets
    super.setState(fn);

    // Calculate seats cost
    final String _shotSelected = _shotTypologies[_shotTyplogyPicked.index];
    _totalCost = _shotTypologyPrices[_shotSelected] * _seatsPicked.length;

    // Calculate snacks cost
    for (var snack in _snacks.values)
      _totalCost +=
          _snackTypologies[snack.label].priceList[snack.dim] * snack.quantity;
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
                  _buildSeats(rows: _roomDim[0], columns: _roomDim[1]),
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

  Widget _buildSeats({rows, columns, height: 250.0}) {
    List<Row> checkBoxRows = [];
    final bool _isDarkThemeEnabled =
        Theme.of(context).backgroundColor == Colors.black;

    for (int i = 0; i < rows; i++) {
      List<SeatCheckBox> checkBoxRow = [];
      for (int j = 0; j < columns; j++) {
        final SeatCheckBox _seat = SeatCheckBox(
          width: MediaQuery.of(context).size.width / 12,
          backgroundColor: _isDarkThemeEnabled ? Colors.black : Colors.white,
          backgroundColorChecked: Colors.deepOrange[900],
          borderColor: _isDarkThemeEnabled ? Colors.grey : Colors.grey[600],
          borderColorChecked: Colors.deepOrange,
          highlightColor: _isDarkThemeEnabled
              ? Colors.white24
              : Colors.deepOrange[500].withOpacity(0.5),
          splashColor:
              _isDarkThemeEnabled ? Colors.white38 : Colors.deepOrange[900],
          checked: false,
          disabled: _seatsStatus[i][j],
          onCheckChange: (status) {
            setState(() {
              final int x = rows - i;
              final int y = j + 1;
              if (status)
                _seatsPicked.add(formatSeat(x, y));
              else
                _seatsPicked.remove(formatSeat(x, y));
            });
          },
        );
        checkBoxRow.add(_seat);
      }
      checkBoxRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: checkBoxRow,
        ),
      );
    }

    return Container(
      key: ValueKey<List<String>>(_hours),
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
                _seatsPicked.isEmpty == true
                    ? "..."
                    : "${_seatsPicked.join(', ')}",
                style: _secondaryStyle,
                key: ValueKey<int>(_seatsPicked.length),
              ),
            ),
          ),
        ],
      ),
    );
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
      DateTime _picked = await selectDate(
        context: context,
        currentDate: this._dateTimePicked,
        firstDate: this._minDate,
        lastDate: this._maxDate,
        unselectableDays: _unselectableDays,
      );
      if (_picked != null) {
        setState(() {
          _dateTimePicked = DateTime(
            _picked.year,
            _picked.month,
            _picked.day,
          );
          // TODO: Qui bisogna aggiornare hours in base al giorno selezionato
          /*
          _hours = getHoursForDate(
            widget.film,
            _shotTypologies[_shotTyplogyPicked.index],
            _dateTimePicked,
          );
          _timePicked = _hours[0];
          */
          _seatsPicked = [];
        });
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
              formatDate(_datePicked, 'G/M'),
              style: _secondaryStyle,
            ),
            Icon(Icons.keyboard_arrow_left),
          ],
        ),
        onPressed: _selectDate,
      ),
    );
  }

  Widget _timePicker(TextStyle _secondaryStyle) {
    Function _onChanged;
    if (_datePicked != null) // Date not selected yet
      _onChanged = (String newValue) => setState(() {
            _seatsPicked = [];
            _timePicked = newValue;
            // TODO: Qui vanno aggiornati i posti disponibili in base a giorno e orario
            for (int i = 0; i < _seatsStatus.length; i++)
              for (int j = 0; j < _seatsStatus[i].length; j++)
                _seatsStatus[i][j] = Random().nextBool();
          });

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
            hint: Text(
              "H:M",
              style: _secondaryStyle,
            ),
            disabledHint: Text(
              "H:M",
              style: _secondaryStyle.copyWith(
                color: Theme.of(context).textTheme.title.color.withOpacity(0.3),
              ),
            ),
            onChanged: _onChanged,
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
    // Build selectors individually
    List<Widget> _snackSelectors = [];
    for (var key in _snackTypologies.keys) {
      // Get current quantities
      Map<String, int> _initialQuantities = {};
      for (String _dim in _snackTypologies[key].priceList.keys) {
        _initialQuantities[_dim] =
            _snacks.containsKey(key + _dim) ? _snacks[key + _dim].quantity : 0;
      }

      // Create selector
      _snackSelectors.add(
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 14,
          ),
          child: SnackSelector(
            snackTypology: _snackTypologies[key],
            initialQuantities: _initialQuantities,
            onSnackChanged: (Snack snack) {
              setState(() {
                if (snack.quantity > 0)
                  _snacks[snack.label + snack.dim] = snack;
                else
                  _snacks.remove(snack.label + snack.dim);
              });
            },
          ),
        ),
      );
    }

    return ExpansionTile(
      title: Text(
        "Vuoi includere uno snack?",
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height / 40,
        ),
      ),
      children: _snackSelectors,
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
            onTap: this._seatsPicked.length == 0
                ? null
                : () {
                    Navigator.push(
                      context,
                      SlideLeftRoute(
                        page: Checkout(
                          film: widget.film,
                          shotTypology:
                              _shotTypologies[_shotTyplogyPicked.index],
                          time: _timePicked,
                          date: formatDate(
                              _datePicked, 'Errore, data non selezionata!'),
                          seats: _seatsPicked,
                          snacks: _snacks.values.toList(),
                          totalCost: _totalCost,
                        ),
                      ),
                    );
                  },
          ),
        ),
      ],
    );
  }
}

/// Just a placeholder to show that some days can't be selected
List<DateTime> getDaysForShot(Film film, String shot) {
  final x = List<DateTime>.generate(Random().nextInt(4),
      (int i) => DateTime.now().add(Duration(days: 1 + Random().nextInt(8))));
  return x;
}

/// Just a placeholder to show that, depending on day and shot, hours could change
List<DateTime> getHoursForDate(Film film, String shot, DateTime date) {
  final DateTime _now = DateTime.now();
  return List<DateTime>.generate(
    Random().nextInt(5),
    (int i) => DateTime(
      _now.year,
      _now.month,
      _now.day,
      16 + Random().nextInt(8),
      [0, 15, 30, 45][Random().nextInt(4)],
    ),
  );
}

/// Just a placeholder to show that some seats can't be selected depending on date and time
List<List<bool>> getSeatsStatus(DateTime date, DateTime time) {
  List<int> _roomDim = [6, 8]; // Rows, columns

  List<List<bool>> _out = [];
  for (int i = 0; i < _roomDim[0]; i++)
    for (int j = 0; j < _roomDim[1]; j++) _out[i][j] = Random().nextBool();
  return _out;
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
*/