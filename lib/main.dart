// Copyright 2020 Amatucci & Strippoli. All rights reserved.

// Import flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

// Local preferences
import 'package:shared_preferences/shared_preferences.dart';

// Import themes related stuff
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:cinema_app/theme/dark_style.dart';
import 'package:cinema_app/theme/light_style.dart';

// Import custom widgets
import 'package:cinema_app/widgets/appbars/default_appbar.dart';
import 'package:cinema_app/widgets/bubble_tab_bar/navbar_item_data.dart';
import 'package:cinema_app/widgets/bubble_tab_bar/navbar.dart';

// Import initial screens
import 'screens/home/home.dart';
import 'screens/tickets/tickets.dart';
import 'screens/profile/root.dart';
import 'screens/settings/settings.dart';
import 'screens/info/root.dart';

void main() => runApp(CinemaApp());

class CinemaApp extends StatefulWidget {
  final bottomNavbarItems = [
    NavBarItemData("Info", OMIcons.info, 90),
    NavBarItemData("Biglietti", OMIcons.receipt, 120),
    NavBarItemData("Home", OMIcons.home, 110),
    NavBarItemData("Profilo", OMIcons.person, 110),
    NavBarItemData("Impostazioni", OMIcons.settings, 160),
  ];
  @override
  _State createState() => _State();
}

class _State extends State<CinemaApp> {
  // Shared preference to get city name
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Working variable for bottom appbar
  int _selectedNavIndex = 2;
  String _selectedCity;

  @override
  void initState() {
    super.initState();
    // Get last selected city, if any
    _prefs.then((SharedPreferences prefs) {
      _selectedCity = prefs.getString('CitySelected');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Choose current widget to visualize
    Widget _contentView;
    switch (_selectedNavIndex) {
      case 0:
        _contentView = CinemaInfo(_selectedCity);
        break;
      case 1:
        _contentView = TicketScreen();
        break;
      case 2:
        _contentView = HomeScreen();
        break;
      case 3:
        _contentView = ProfileScreen();
        break;
      case 4:
        _contentView = SettingScreen();
        break;
    }

    // Configuring theme changer
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) {
        if (brightness == Brightness.light)
          return appLightTheme();
        else
          return appDarkTheme();
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // To be removed
          title: 'Cinema App',
          theme: theme,
          // Configuring language
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('it'),
          ],
          // Displaying main container, appbar and bottom navbar
          home: Scaffold(
            appBar: DefaultAppBar(
              initialSelectedCity: _selectedCity,
              onCityChange: (String city) =>
                  setState(() => _selectedCity = city),
            ),
            body: Container(
              width: double.infinity,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 350),
                child: _contentView,
              ),
            ),
            bottomNavigationBar: NavBar(
              items: widget.bottomNavbarItems,
              itemTapped: (int index) =>
                  setState(() => _selectedNavIndex = index),
              currentIndex: _selectedNavIndex,
            ),
          ),
        );
      },
    );
  }
}
