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
