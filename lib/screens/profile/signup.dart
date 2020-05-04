// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Database interface
import 'package:cinema_app/services/auth.dart';

//Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'package:flutter/services.dart';
import 'components/custom_form_field.dart';

// Email validator for the form
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  final Auth auth = Auth();

  @override
  State createState() => new _State();
}

class _State extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _signUpFormKey = GlobalKey<FormState>();
  String _name;
  String _surname;
  String _email;
  String _password;
  String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: GoBackAppBar("Registrazione").build(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 32),
        child: Column(
          children: <Widget>[
            _infoBox(context,
                "Inserisci tutti i dati richiesti per poter creare il tuo account personale"),
            Form(
              key: _signUpFormKey,
              child: Column(
                children: <Widget>[
                  CustomFormField(
                    icon: Icons.person,
                    label: "Nome",
                    hint: 'Inserisci il tuo nome',
                    inputType: TextInputType.text,
                    validator: (String name) {
                      name = name.trim();
                      if (name.isEmpty) return 'Questo campo è obbligatorio';
                      return null;
                    },
                    onSaved: (String name) => _name = name.trim(),
                  ),
                  CustomFormField(
                    icon: Icons.person,
                    label: "Cognome",
                    hint: 'Inserisci il tuo cognome',
                    inputType: TextInputType.text,
                    validator: (String surname) {
                      surname = surname.trim();
                      if (surname.isEmpty) return 'Questo campo è obbligatorio';
                      return null;
                    },
                    onSaved: (String surname) => _surname = surname.trim(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
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
                  CustomFormField(
                    icon: Icons.check,
                    label: "Conferma Password",
                    hint: 'Reinserisci la tua password',
                    inputType: TextInputType.visiblePassword,
                    validator: (String password) {
                      password = password.trim();
                      if (password.isEmpty)
                        return 'Questo campo è obbligatorio';
                      if (password.length < 6)
                        return 'La password deve avere almeno 6 caratteri';
                      if (_password != _confirmPassword)
                        return 'Le due password devono corrispondere';
                      return null;
                    },
                    onSaved: (String password) =>
                        _confirmPassword = password.trim(),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 27),
            CustomButton(
              width: MediaQuery.of(context).size.width / 2.8,
              height: MediaQuery.of(context).size.height / 18,
              text: 'Registrati',
              onTap: () async {
                // Validate form
                _signUpFormKey.currentState.save();
                if (!_signUpFormKey.currentState.validate()) return null;

                // Show snackbar to notify user that registration is going on
                FocusScope.of(context).requestFocus(FocusNode());
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Row(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        Text("Registrazione in corso...")
                      ],
                    ),
                  ),
                );

                // Try to perform a registration
                try {
                  await widget.auth.signUp(_email, _password, _name, _surname);
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                          "La registrazione è avvenuta con successo! Controlla la tua mail, dopodiché effettua il tuo primo login!"),
                    ),
                  );
                } catch (e) {
                  print(e);
                  final String _error = e.code == 'ERROR_EMAIL_ALREADY_IN_USE'
                      ? "L'email scelta è già in uso da un altro utente. Riprova."
                      : "Si è verificato un errore. Riprova.";
                  // Display error to the user
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(_error),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(context, text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: MediaQuery.of(context).size.height / 47,
        color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
      ),
    );
  }
}
