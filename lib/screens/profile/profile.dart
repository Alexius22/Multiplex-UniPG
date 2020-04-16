// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3.1, top: 5),
                child: Text(
                  "Account",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height / 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    bottom: MediaQuery.of(context).size.width / 30),
                child: Container(
                  width: MediaQuery.of(context).size.height / 7,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[900],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.height / 35),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Mario Verdi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 35,
                      ),
                    ),
                    Text(
                      "Perugia (PG)",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(
              "Password",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            subtitle: Text(
              "********",
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Email",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            subtitle: Text(
              "prova@example.com",
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Pagamento",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            subtitle: Text(
              "Visa xxxx-xxxx-xxxx-1234",
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
