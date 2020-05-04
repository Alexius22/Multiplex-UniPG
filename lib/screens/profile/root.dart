// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Database interface
import 'package:firebase_auth/firebase_auth.dart';

// Widgets
import 'package:cinema_app/widgets/loading/loading_screen.dart';

// Screens
import 'login.dart';
import 'logged_in.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else if (snapshot.hasData && snapshot.data.isEmailVerified) {
          return LoggedInScreen(user: snapshot.data);
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
