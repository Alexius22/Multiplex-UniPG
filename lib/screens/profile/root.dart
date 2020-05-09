// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Database interface
import 'package:firebase_auth/firebase_auth.dart';

// Widgets
import 'package:cinema_app/widgets/loading/loading_screen.dart';
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';

// Screens
import 'login.dart';
import 'logged_in.dart';

class ProfileScreen extends StatelessWidget {
  final bool standalone;
  ProfileScreen({this.standalone = false});

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else if (snapshot.hasData && snapshot.data.isEmailVerified) {
          if (!standalone) return LoggedInScreen(user: snapshot.data);
          Navigator.pop(context, true);
          return Scaffold();
        } else {
          if (!standalone) return LoginScreen();
          return Scaffold(
            appBar: GoBackAppBar('').build(context),
            body: LoginScreen(),
          );
        }
      },
    );
  }
}
