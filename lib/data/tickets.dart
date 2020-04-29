import 'dart:math';
import './snacks.dart';

/// Utility class that contains info about a single ticket.
class TicketData {
  final int idCity;

  final int idFilm; // PK
  final DateTime filmDateTime; // PK

  final int room; // PK
  final String row; // PK
  final int seat; // PK

  final List<Snack> snacks;

  TicketData({
    this.idCity,
    this.idFilm,
    this.filmDateTime,
    this.room,
    this.row,
    this.seat,
    this.snacks,
  });
}

// Hacky way to get a list of all the snacks, in the release we will just take values from DB
final List<Snack> _snacks = SnackData()
    .getAll
    .expand((SnackTypology el) {
      List<Snack> tmp = [];
      for (var dim in el.priceList.keys) tmp.add(Snack(el.label, dim, 0));
      return tmp;
    })
    .toList()
    .cast<Snack>();

/// Class that contains some example instances of tickets.
class TicketsData {
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
          [0, 15, 30, 45][_random.nextInt(4)],
        ),
        room: 1 + _random.nextInt(6),
        row: String.fromCharCode(65 + _random.nextInt(20)),
        seat: 1 + _random.nextInt(20),
        snacks: List<Snack>.generate(
          _random.nextInt(8),
          (int i) {
            // Generate a random snack with random quantity as well
            Snack randSnack = _snacks[_random.nextInt(_snacks.length)];
            randSnack.quantity = 1 + _random.nextInt(15);
            return randSnack;
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
