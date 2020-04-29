// Copyright 2020 Amatucci & Strippoli. All rights reserved.

/// Utility class that contains info about a single snack.
class SnackTypology {
  final String label; // PK
  final Map<String, double> priceList;

  SnackTypology({
    this.label,
    this.priceList,
  });
}

class Snack {
  final String label; // PK
  final String dim; // PK
  int quantity;

  Snack(
    this.label,
    this.dim,
    this.quantity,
  );
}

final List<String> _allSizesSnackLables = [
  'PopCorn',
  'Patatine',
  'Caramelle',
  'Nachos',
  'Hot Dog',
  'Menù nachos',
  'Menù PopCorn',
  'Yogurt',
  'Coca-Cola',
  'Fanta',
  'Sprite',
];
List<String> _oneSizeSnackLabels = [
  'Acqua',
  'Smarties',
  'Twix',
  'Bounty',
  'Mars',
];

/// Class that contains some example instances of cities.
class SnackData {
  final List<SnackTypology> _snackTypologies = List<SnackTypology>.generate(
        _allSizesSnackLables.length,
        (int index) => SnackTypology(
          label: _allSizesSnackLables[index],
          priceList: {'Piccolo': 2.0, 'Medio': 3.0, 'Grande': 4.0},
        ),
      ) +
      List<SnackTypology>.generate(
        _oneSizeSnackLabels.length,
        (int index) => SnackTypology(
          label: _oneSizeSnackLabels[index],
          priceList: {'': 1.5},
        ),
      );

  get getAll => _snackTypologies;
}
