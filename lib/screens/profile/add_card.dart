// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildBackButton(context),
          _buildHead(),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _form("Intestatario carta:", Icons.person, "Nome Cognome",
                      TextInputType.text),
                  _form("Numero carta:", Icons.credit_card,
                      "1234 1234 1234 1234", TextInputType.number),
                  _form("Data di scadenza:", Icons.calendar_today, "01/2020",
                      TextInputType.number),
                  _form("CVV:", Icons.vpn_key, "123", TextInputType.number),
                  _saveButton(),
                ],
              ),
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
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            "Nuova carta",
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

  Widget _form(title, icon, hintText, keyboard) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 7,
          right: MediaQuery.of(context).size.width / 7),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0.2),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  keyboardType: keyboard,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Center(
          child: Container(
            height: 50,
            width: 200,
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
                  Text(
                    "Aggiungi carta",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
