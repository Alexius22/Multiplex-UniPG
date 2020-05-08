// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/services/auth.dart';

// Models
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';

// Widget
import 'package:cinema_app/widgets/buttons/custom_button.dart';

// Utils
import 'package:cinema_app/utils/calendar.dart';
import 'package:cinema_app/utils/format.dart';

// Next page
import 'package:cinema_app/transitions/slide_top_route.dart';
import 'package:cinema_app/screens/home/buy_ticket/buy_ticket.dart';
import 'package:cinema_app/screens/profile/login.dart';

class FilmDetailsFooter extends StatefulWidget {
  final Film film;
  final List<Schedule> schedules;
  final double height;
  final double gradientHeight;
  final double bottomPadding;

  FilmDetailsFooter({
    this.film,
    this.schedules,
    this.height,
    this.gradientHeight,
    this.bottomPadding,
  });

  @override
  _State createState() => new _State();
}

class _State extends State<FilmDetailsFooter> with TickerProviderStateMixin {
  // User choices
  DateTime _dateTimePicked;
  TabController _shotTypologyController;

  // Working variables
  List<String> _shotTypologies;
  Map<String, List<String>> _hours;

  @override
  Widget build(BuildContext context) {
    // Style config
    final TextStyle _secondaryStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
      fontSize: MediaQuery.of(context).size.height / 40,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Gradient
          Padding(
            padding:
                EdgeInsets.only(bottom: widget.height + widget.bottomPadding),
            child: Container(
              width: double.infinity,
              height: widget.gradientHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).backgroundColor,
                    Theme.of(context).backgroundColor.withOpacity(0.0),
                  ],
                  stops: [0.2, 1.0],
                ),
              ),
            ),
          ),
          // Divider
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / 40,
              bottom: widget.height +
                  widget.bottomPadding -
                  MediaQuery.of(context).size.height / 160,
            ),
            child: Divider(color: Theme.of(context).textTheme.title.color),
          ),
          // Selections
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / 40,
              bottom: MediaQuery.of(context).size.height / 13 +
                  widget.bottomPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _datePicker(_secondaryStyle),
                _buildShotTypology(_secondaryStyle),
                _timePicker(_secondaryStyle),
              ],
            ),
          ),
          // Preorder button
          Padding(
            padding: EdgeInsets.only(bottom: widget.bottomPadding),
            child: CustomButton(
              width: MediaQuery.of(context).size.width / 2.75,
              height: MediaQuery.of(context).size.height / 18,
              text: "Prenota",
              icon: Icons.arrow_forward_ios,
              onTap: _dateTimePicked != null
                  ? () async {
                      return await Auth().getCurrentUser() != null
                          ? Navigator.push(
                              context,
                              SlideTopRoute(
                                page: BuyTicket(
                                  film: widget.film,
                                  // This is a little unsafe, could check 'where' output length
                                  schedule: widget.schedules
                                      .where(
                                        (Schedule s) =>
                                            s.dateTime == _dateTimePicked &&
                                            s.shotTypology ==
                                                _shotTypologies[
                                                    _shotTypologyController
                                                        .index],
                                      )
                                      .elementAt(0),
                                ),
                              ),
                            )
                          : Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Per poter prenotare\ndevi autenticarti.",
                                      style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width /
                                          2.75,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      text: "Autenticati",
                                      onTap: () {
                                        //TODO Fix the navbar and appbar
                                        Navigator.push(
                                          context,
                                          SlideTopRoute(
                                            page: LoginScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }
                  : null,
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
              SizedBox(width: MediaQuery.of(context).size.width / 110),
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

  Widget _datePicker(_secondaryStyle) {
    // Save now for multiple uses
    final DateTime _now = DateTime.now();
    final List<DateTime> _selectableDays = widget.schedules
        .map((Schedule s) => s.dateTime)
        .where((DateTime d) => _now.isBefore(d))
        .toList();

    // Check for errors (this should never happen)
    if (_selectableDays.length == 0)
      return Text("Errore!\nNon disponibile...", textAlign: TextAlign.center);

    // Internal function for calendar
    Future _selectDate() async {
      DateTime _picked = await selectDate(
        context: context,
        currentDate: this._dateTimePicked,
        firstDate: _now,
        lastDate: _now.add(Duration(days: 30)),
        selectableDays: _selectableDays,
      );
      if (_picked != null) {
        setState(() {
          _dateTimePicked = DateTime(
            _picked.year,
            _picked.month,
            _picked.day,
          );

          // Get schedule of selected day
          final List<Schedule> _validSchedules = widget.schedules
              .where((Schedule s) =>
                  s.dateTime.year == _picked.year &&
                  s.dateTime.month == _picked.month &&
                  s.dateTime.day == _picked.day)
              .toList();

          // Extract shot typologies for today schedule
          _shotTypologies = _validSchedules
              .map((Schedule s) => s.shotTypology)
              .toSet()
              .toList();

          // Extract hours based on shot typology choice
          _hours = {};
          for (String typo in _shotTypologies)
            _hours[typo] = _validSchedules
                .where((Schedule s) => s.shotTypology == typo)
                .map((Schedule s) => formatTime(s.dateTime))
                .toList();

          final DateTime _newTime =
              formatTimeReverse(_hours[_shotTypologies[0]][0]);
          _dateTimePicked = DateTime(
            _dateTimePicked.year,
            _dateTimePicked.month,
            _dateTimePicked.day,
            _newTime.hour,
            _newTime.minute,
          );

          // Initialize shot typology tab controller
          _shotTypologyController = TabController(
              vsync: this, initialIndex: 0, length: _shotTypologies.length);
          _shotTypologyController.addListener(() {
            if (_shotTypologyController.indexIsChanging) {
              setState(() {
                final DateTime _newTime = formatTimeReverse(
                    _hours[_shotTypologies[_shotTypologyController.index]][0]);
                _dateTimePicked = DateTime(
                  _dateTimePicked.year,
                  _dateTimePicked.month,
                  _dateTimePicked.day,
                  _newTime.hour,
                  _newTime.minute,
                );
              }); // Refresh
            }
          });
        });
      }
    }

    return _shotdDateTimePicker(
      "Giorno",
      Icons.calendar_today,
      FlatButton(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 50),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        highlightColor:
            Theme.of(context).textTheme.title.color.withOpacity(0.1),
        splashColor: Theme.of(context).textTheme.title.color.withOpacity(0.2),
        child: Row(
          children: <Widget>[
            Text(
              _dateTimePicked != null ? formatDate(_dateTimePicked) : 'G/M',
              style: _secondaryStyle,
            ),
            Icon(Icons.keyboard_arrow_left),
          ],
        ),
        onPressed: _selectDate,
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
            width: MediaQuery.of(context).size.width / 3.4,
            height: MediaQuery.of(context).size.height / 25,
            child: _shotTypologyController != null
                ? TabBar(
                    controller: _shotTypologyController,
                    tabs: _shotTypologies.map((typ) => Tab(text: typ)).toList(),
                    labelColor: _secondaryStyle.color,
                    unselectedLabelColor: Theme.of(context)
                        .textTheme
                        .title
                        .color
                        .withOpacity(0.3),
                    labelStyle: _secondaryStyle,
                  )
                : Text(
                    "?",
                    style: _secondaryStyle.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .title
                          .color
                          .withOpacity(0.3),
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _timePicker(TextStyle _secondaryStyle) {
    if (_shotTypologyController == null)
      return _shotdDateTimePicker(
        "Orario",
        Icons.schedule,
        Container(
          height: MediaQuery.of(context).size.height / 25,
          child: Text(
            "H:M",
            style: _secondaryStyle.copyWith(
              color: Theme.of(context).textTheme.title.color.withOpacity(0.3),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

    return _shotdDateTimePicker(
      "Orario",
      Icons.schedule,
      Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 100),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isDense: true,
            value: _hours != null ? formatTime(_dateTimePicked) : null,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: MediaQuery.of(context).size.height / 37,
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
            onChanged: (String s) => setState(() {
              final DateTime _newTime = formatTimeReverse(s);
              _dateTimePicked = DateTime(
                _dateTimePicked.year,
                _dateTimePicked.month,
                _dateTimePicked.day,
                _newTime.hour,
                _newTime.minute,
              );
            }),
            items: _hours[_shotTypologies[_shotTypologyController.index]]
                .map<DropdownMenuItem<String>>((String value) {
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
}
