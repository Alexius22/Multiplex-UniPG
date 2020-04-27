// Copyright 2020 Amatucci & Strippoli. All rights reserved.

// Import flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

// Import themes related stuff
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:cinema_app/theme/dark_style.dart';
import 'package:cinema_app/theme/light_style.dart';

// Import custom widgets
import 'package:cinema_app/widgets/bubble_tab_bar/navbar_item_data.dart';
import 'package:cinema_app/tabbar.dart';

// Import initial screens
import 'screens/home/home.dart';
import 'screens/tickets/tickets.dart';
import 'screens/profile/profile.dart';
import 'screens/settings/settings.dart';
import 'screens/info/info_cinema.dart';

// Import cities data
import 'package:cinema_app/data/cities.dart';

void main() => runApp(CinemaApp());

class CinemaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) {
        if (brightness == Brightness.light)
          return appLightTheme();
        else
          return appDarkTheme();
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'Cinema App',
          theme: theme,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('it'),
          ],
          home: BubbleTabBar(
            items: [
              NavBarItemData("Info", OMIcons.info, 100, InfoCinema()),
              NavBarItemData("Biglietti", OMIcons.receipt, 130, TicketScreen()),
              NavBarItemData("Home", OMIcons.home, 120, HomeScreen()),
              NavBarItemData("Profilo", OMIcons.person, 120, ProfileScreen()),
              NavBarItemData(
                  "Impostazioni", OMIcons.settings, 165, SettingScreen()),
            ],
            cities: CitiesData().getAllStrings(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
