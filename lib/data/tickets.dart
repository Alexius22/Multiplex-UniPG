import 'dart:math';

/// Utility class that contains info about a single ticket.
class TicketData {
  final int idCity;

  final int idFilm;
  final DateTime filmDateTime;

  final int room;
  final String row;
  final int seat;

  TicketData({
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

  final _tickets = List<TicketData>.generate(
    8,
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
          _possibleMinutes[_random.nextInt(_possibleMinutes.length)],
        ),
        room: 1 + _random.nextInt(6),
        row: String.fromCharCode(65 + _random.nextInt(20)),
        seat: 1 + _random.nextInt(20),
      );
    },
  );

  get getAll => _tickets;

  getTicket(int index) {
    return _tickets.elementAt(index);
  }
}