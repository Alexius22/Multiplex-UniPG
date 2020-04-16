import 'dart:math';

/// Utility class that contains info about a single ticket.
class Ticket {
  final int idCity;

  final int idFilm;
  final DateTime filmDateTime;

  final int room;
  final int row;
  final int seat;

  Ticket({
    this.idCity,
    this.idFilm,
    this.filmDateTime,
    this.room,
    this.row,
    this.seat,
  });
}

/// Class that contains some example instances of tickets.
class TicketsData {
  static final _possibleMinutes = [0, 15, 30, 45];

  final _tickets = List<Ticket>.generate(
    8,
    (i) {
      final _random = Random();
      return Ticket(
        idCity: _random.nextInt(3),
        idFilm: _random.nextInt(9),
        filmDateTime: DateTime(
          2020,
          4 + _random.nextInt(3),
          1 + _random.nextInt(31),
          14 + _random.nextInt(10),
          _possibleMinutes[_random.nextInt(_possibleMinutes.length)],
        ),
        room: 1 + _random.nextInt(6),
        row: 1 + _random.nextInt(20),
        seat: 1 + _random.nextInt(20),
      );
    },
  );

  get getAll => _tickets;

  getTicket(int index) {
    return _tickets.elementAt(index);
  }
}
