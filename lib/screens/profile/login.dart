// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 15,
                  bottom: MediaQuery.of(context).size.height / 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: _iconAnimation.value *
                        MediaQuery.of(context).size.height /
                        7,
                  ),
                ],
              ),
            ),
            Container(
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
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.2),
                    child: Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'prova@example.com',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.2),
                    child: Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              height: MediaQuery.of(context).size.height / 15,
              minWidth: MediaQuery.of(context).size.width / 3,
              color: Colors.deepOrange[900],
              splashColor: Colors.deepOrange[300],
              textColor: Colors.white,
              child: Text("LOGIN"),
              onPressed: () {},
            ),
            FlatButton(
              onPressed: () => {},
              child: Text(
                "Password dimenticata?",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 25,
                right: MediaQuery.of(context).size.height / 20,
                left: MediaQuery.of(context).size.height / 20,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image(
                      width: MediaQuery.of(context).size.width / 15,
                      height: MediaQuery.of(context).size.height / 15,
                      image: AssetImage("images/social/facebook.png"),
                    ),
                  ),
                   Expanded(
                    child: Image(
                      width: MediaQuery.of(context).size.width / 15,
                      height: MediaQuery.of(context).size.height / 15,
                      image: AssetImage("images/social/google.png"),
                    ),
                  ),
                   Expanded(
                    child: Image(
                      width: MediaQuery.of(context).size.width / 15,
                      height: MediaQuery.of(context).size.height / 15,
                      image: AssetImage("images/social/linkedin.png"),
                    ),
                  ),
                   Expanded(
                    child: Image(
                      width: MediaQuery.of(context).size.width / 15,
                      height: MediaQuery.of(context).size.height / 15,
                      image: AssetImage("images/social/twitter.png"),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
              onPressed: () => {},
              child: Text(
                "Non hai un account? Creane uno!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
