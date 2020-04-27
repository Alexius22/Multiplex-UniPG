import 'package:flutter/material.dart';

class GoBackAppBar extends StatelessWidget {
  final String title;

  GoBackAppBar(
    this.title,
  );

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        this.title,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height / 32,
          color: Theme.of(context).textTheme.title.color,
        ),
      ),
    );
  }
}
