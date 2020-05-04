// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Database interface
import 'package:cinema_app/services/auth.dart';

// Transitions
import 'package:cinema_app/transitions/slide_top_route.dart';

// Screens
import 'package:cinema_app/screens/profile/signup.dart';
import 'package:cinema_app/screens/profile/forgot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Widgets
import 'components/logo.dart';
import 'components/custom_form_field.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';

// Email validator for the form
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  final Auth auth = Auth();

  @override
  State createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 32),
        child: Column(
          children: <Widget>[
            Logo(
              animated: false,
              finalHeight: MediaQuery.of(context).size.height / 8,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 80),
            Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  CustomFormField(
                    icon: Icons.alternate_email,
                    label: "E-mail",
                    hint: 'Inserisci la tua e-mail',
                    inputType: TextInputType.emailAddress,
                    validator: (String email) {
                      email = email.trim();
                      if (email.isEmpty) return 'Questo campo è obbligatorio';
                      if (!EmailValidator.validate(email))
                        return 'E-mail non valida';
                      return null;
                    },
                    onSaved: (String email) => _email = email.trim(),
                  ),
                  CustomFormField(
                    icon: Icons.lock_open,
                    label: "Password",
                    hint: 'Inserisci la tua password',
                    inputType: TextInputType.visiblePassword,
                    validator: (String password) {
                      password = password.trim();
                      if (password.isEmpty)
                        return 'Questo campo è obbligatorio';
                      if (password.length < 6)
                        return 'La password deve avere almeno 6 caratteri';
                      return null;
                    },
                    onSaved: (String password) => _password = password.trim(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _buildClickableText(
                'Password dimenticata?',
                () => Navigator.push(
                  context,
                  SlideTopRoute(
                    page: Forgot(),
                  ),
                ),
              ),
            ),
            CustomButton(
              width: MediaQuery.of(context).size.width / 4.1,
              height: MediaQuery.of(context).size.height / 20,
              text: 'Login',
              onTap: () async {
                // Validate form
                if (!_loginFormKey.currentState.validate()) return null;

                // Fields are valid, save them
                _loginFormKey.currentState.save();

                // Show snackbar to notify user that login is going on
                FocusScope.of(context).requestFocus(FocusNode());
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        Text("Tentativo di login in corso...")
                      ],
                    ),
                  ),
                );

                // Try to perform a login
                try {
                  final String _userID =
                      await widget.auth.signIn(_email, _password);
                  Scaffold.of(context).hideCurrentSnackBar();
                  // Is email not verified?
                  if (_userID == null)
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "La mail inserita non è stata verificata. Controlla la tua casella di posta."),
                      ),
                    );
                } catch (e) {
                  print(e);
                  // Display error to the user
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Le credenziali inserite non corrispondono a nessun utente. Riprova."),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 52),
            _buildDivider("Oppure effettua il login con..."),
            SizedBox(height: MediaQuery.of(context).size.height / 52),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildSocialLogin(FontAwesomeIcons.facebookF),
                _buildSocialLogin(FontAwesomeIcons.google),
                _buildSocialLogin(FontAwesomeIcons.linkedinIn),
                _buildSocialLogin(FontAwesomeIcons.twitter),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 52),
            _buildDivider("Non sei registrato?"),
            SizedBox(height: MediaQuery.of(context).size.height / 52),
            CustomButton(
              width: MediaQuery.of(context).size.width / 2.8,
              height: MediaQuery.of(context).size.height / 20,
              text: 'Registrati',
              onTap: () => Navigator.push(
                context,
                SlideTopRoute(
                  page: SignUpScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(String text) {
    return Stack(
      children: <Widget>[
        Divider(
          thickness: 1.0,
          color: Colors.grey[600],
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "  $text  ",
            style: TextStyle(
              color: Colors.grey[700],
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin(IconData icon) {
    return IconButton(
      icon: Opacity(
        opacity: 0.85,
        child: FaIcon(icon, size: MediaQuery.of(context).size.height / 14),
      ),
      padding: EdgeInsets.all(0),
      iconSize: MediaQuery.of(context).size.height / 13,
      onPressed: () {},
    );
  }

  Widget _buildClickableText(String text, Function onTap) {
    return FlatButton(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 115,
          right: MediaQuery.of(context).size.width / 115),
      highlightColor: Colors.deepOrange[400].withOpacity(0.2),
      splashColor: Colors.deepOrange[400].withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      onPressed: () => {
        Navigator.push(
          context,
          SlideTopRoute(
            page: Forgot(),
          ),
        ),
      },
    );
  }
}
