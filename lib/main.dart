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
import 'package:cinema_app/widgets/loading/loading_screen.dart';

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
    NavBarItemData("Impostazioni", OMIcons.settings, 170),
  ];
  @override
  _State createState() => _State();
}

Widget _buildContentView(int navIndex, String city) {
  switch (navIndex) {
    case 0:
      return CinemaInfo(city);
    case 1:
      return TicketScreen();
    case 2:
      return HomeScreen(city);
    case 3:
      return ProfileScreen();
    case 4:
      return SettingScreen();
    default:
      break;
  }
  return Placeholder();
}

class _State extends State<CinemaApp> {
  // Working variable for bottom appbar
  int _selectedNavIndex = 2;

  @override
  Widget build(BuildContext context) {
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
          home: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              // Loading
              if (!snapshot.hasData) return LoadingScreen();

              // Get selected city
              final String _cityPicked = snapshot.data.getString('City');

              return Scaffold(
                appBar: DefaultAppBar(
                  initialSelectedCity: _cityPicked,
                  onCityChange: (String city) => setState(() {}),
                ),
                body: Container(
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 350),
                    child: _buildContentView(_selectedNavIndex, _cityPicked),
                  ),
                ),
                bottomNavigationBar: NavBar(
                  items: widget.bottomNavbarItems,
                  itemTapped: (int index) =>
                      setState(() => _selectedNavIndex = index),
                  currentIndex: _selectedNavIndex,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
