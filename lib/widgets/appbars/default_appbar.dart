import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/services/cinemas.dart';

// Local preferences
import 'package:shared_preferences/shared_preferences.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String initialSelectedCity;
  final Function onCityChange;

  DefaultAppBar({Key key, this.initialSelectedCity, this.onCityChange})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  DefaultAppBarState createState() => DefaultAppBarState();
}

class DefaultAppBarState extends State<DefaultAppBar> {
  String _cityPicked;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _cityPicked = widget.initialSelectedCity;
  }

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Center(child: _buildCitiesDropDown()),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 26),
            child: Image.asset(
              'images/logo.png',
              height: MediaQuery.of(context).size.height / 27,
            ),
          ),
          Text(
            'Multiplex UniPG'.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 42,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildCitiesDropDown() {
    return FutureBuilder<List<String>>(
      future: FirestoreCinemas().getCinemasCities(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
            hint: Text("La tua città..."),
            value: _cityPicked,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: MediaQuery.of(context).size.height / 26,
            underline: Container(
              height: 0,
            ),
            onChanged: (String newValue) async {
              final SharedPreferences prefs = await _prefs;
              setState(() {
                _cityPicked = newValue;
                // Save preference
                prefs.setString("City", newValue).then((bool success) {
                  return newValue;
                });
                // Callback to update children values
                widget.onCityChange(_cityPicked);
              });
            },
            items: snapshot.data.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }
        return Padding(
          padding: EdgeInsets.only(right: 10),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
