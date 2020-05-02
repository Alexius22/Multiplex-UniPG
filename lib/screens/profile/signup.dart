// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

//Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar("Registrazione").build(context),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _infoBox(context,
                    "Inserisci tutti i dati richiesti per poter creare il tuo account personale"),
                _form(context, "Inserisci il tuo nome:", Icons.person,
                    "Nome", TextInputType.text),
                _form(context, "Inserisci il tuo cognome:", Icons.person,
                    "Cognome", TextInputType.text),
                _form(context, "Inserisci la tua email:", Icons.alternate_email,
                    "prova@example.com", TextInputType.emailAddress),
                _form(context, "Inserisci password:", Icons.vpn_key, "Password",
                    TextInputType.visiblePassword),
                _form(context, "Conferma password:", Icons.check,
                    "Conferma Password", TextInputType.visiblePassword),
                _saveUser(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(context, text) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: MediaQuery.of(context).size.height / 47,
                  color:
                      Theme.of(context).textTheme.title.color.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(context, title, icon, hintText, keyboard) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 10),
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
                  fontSize: MediaQuery.of(context).size.height / 40,
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
                  size: MediaQuery.of(context).size.height / 23,
                ),
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .title
                          .color
                          .withOpacity(0.5),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 32,
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

  Widget _saveUser(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width / 2.05,
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
                    "Registrati",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 40,
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
