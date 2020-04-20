import 'dart:math';

/// Utility class that contains info about a single ticket.
class TicketData {
  final int idCity;

  final int idFilm;
  final DateTime filmDateTime;

  final int room;
  final String row;
  final int seat;

  final List<Consumable> consumables;

  TicketData({
    this.idCity,
    this.idFilm,
    this.filmDateTime,
    this.room,
    this.row,
    this.seat,
    this.consumables,
  });
}

class Consumable {
  final String label;
  final String dim;
  final int n;

  Consumable({
    this.label,
    this.dim,
    this.n,
  });
}

/// Class that contains some example instances of tickets.
class TicketsData {
  static final _minutes = [0, 15, 30, 45];
  static final _consumableLabels = [
    [
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
    ],
    [
      'Acqua',
      'Smarties',
      'Twix',
      'Bounty',
      'Mars',
    ]
  ];
  static final _consumableDims = ['Small', 'Medium', 'Large'];

  final _tickets = List<TicketData>.generate(
    16,
    (i) {
      final _random = Random();
      return TicketData(
        idCity: _random.nextInt(4),
        idFilm: _random.nextInt(8),
        filmDateTime: DateTime(
          2020,
          4 + _random.nextInt(3),
          1 + _random.nextInt(31),
          14 + _random.nextInt(10),
          _minutes[_random.nextInt(_minutes.length)],
        ),
        room: 1 + _random.nextInt(6),
        row: String.fromCharCode(65 + _random.nextInt(20)),
        seat: 1 + _random.nextInt(20),
        consumables: List<Consumable>.generate(
          _random.nextInt(8),
          (i) {
            int _typeConsumable = _random.nextInt(2);
            return Consumable(
              label: _consumableLabels[_typeConsumable]
                  [_random.nextInt(_consumableLabels.length)],
              dim: _typeConsumable == 0
                  ? _consumableDims[_random.nextInt(_consumableDims.length)]
                  : 'No size',
              n: 1 + _random.nextInt(4),
            );
          },
        ),
      );
    },
  );

  get getAll => _tickets;

  getTicket(int index) {
    return _tickets.elementAt(index);
  }
}
