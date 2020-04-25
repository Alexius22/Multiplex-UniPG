// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final ValueChanged<bool> onLogin;
  const LoginScreen({this.onLogin});

  @override
  State createState() => new LoginScreenState(onLogin: onLogin);
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  final ValueChanged<bool> onLogin;
  LoginScreenState({this.onLogin});

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    void _onLoginPressed() {
      onLogin(true);
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 40,
                  bottom: MediaQuery.of(context).size.height / 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    height: _iconAnimation.value *
                        MediaQuery.of(context).size.height /
                        6,
                    image: AssetImage(
                      "images/logo.png",
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
                      Icons.alternate_email,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'prova@example.com',
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
                        ),
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
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
                        ),
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
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: MediaQuery.of(context).size.height / 18,
              minWidth: MediaQuery.of(context).size.width / 5,
              color: Colors.deepOrange[900],
              splashColor: Colors.deepOrange[300],
              textColor: Colors.white,
              child: Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: _onLoginPressed,
            ),
            MaterialButton(
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
                top: MediaQuery.of(context).size.height / 30,
                right: MediaQuery.of(context).size.height / 20,
                left: MediaQuery.of(context).size.height / 20,
              ),
              child: Row(
                children: <Widget>[
                  _buildSocialImg("images/social/facebook.png"),
                  _buildSocialImg("images/social/google.png"),
                  _buildSocialImg("images/social/linkedin.png"),
                  _buildSocialImg("images/social/twitter.png"),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 24,
            ),
            MaterialButton(
              onPressed: () => {},
              child: Text(
                "Non hai un account? Creane uno!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 52,
            ),
          ],
        ),
      ),
    );
  }

  _buildSocialImg(imgPath) {
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Ink(
            child: IconButton(
              icon: Image.asset(imgPath),
              iconSize: MediaQuery.of(context).size.height / 12,
              padding: EdgeInsets.all(0),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
