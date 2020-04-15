import 'package:flutter/material.dart';

class DateMenu extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<DateMenu> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          color: Colors.deepOrange[900],
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          splashColor: Colors.deepOrange[300],
          onPressed: () {},
          child: Text(
            "Oggi",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          color: Colors.black,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          splashColor: Colors.deepOrange[300],
          onPressed: () {
            /*...*/
          },
          child: Text(
            "Domani",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          color: Colors.black,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          splashColor: Colors.deepOrange[300],
          onPressed: () {
            Future<DateTime> selectedDate = showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2030),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.dark(),
                  child: child,
                );
              },
            );
          },
          child: Text(
            "Scegli data",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}
