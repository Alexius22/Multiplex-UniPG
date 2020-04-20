// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class LoggedInScreen extends StatefulWidget {
  final ValueChanged<bool> onLogin;
  const LoggedInScreen({this.onLogin});

  @override
  _State createState() => new _State(onLogin: onLogin);
}

class _State extends State<LoggedInScreen> {
  final ValueChanged<bool> onLogin;
  _State({this.onLogin});

  @override
  Widget build(BuildContext context) {
    void _onLogoutPressed() {
      onLogin(false);
    }

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.height / 7,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Oswald Green",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: MediaQuery.of(context).size.height / 25,
                      ),
                    ),
                    Text(
                      "Perugia (PG)",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 42,
                        letterSpacing: 1,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _listDrop("Password", "********"),
          _listDrop("Email", "prova@example.com"),
          _listDrop("Pagamento", "Visa xxxx-xxxx-xxxx-1234"),
          _tileLogout("Logout", "Effettua il logout di questo account", _onLogoutPressed),
        ],
      ),
    );
  }

  Widget _listDrop(primary, secondary) {
    return ListTile(
      title: Text(
        primary,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(secondary,
          style: TextStyle(
            color: Colors.grey.shade400,
          )),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey.shade400,
      ),
      onTap: () {},
    );
  }

  Widget _tileLogout(text, secondary, func) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height / 40,
        ),
      ),
      subtitle: Text(secondary,
          style: TextStyle(
            color: Colors.grey.shade400,
          )),
      onTap: func,
    );
  }
}
