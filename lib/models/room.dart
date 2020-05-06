import 'cinema.dart';

class Room {
  final String id;
  final Cinema cinema;
  final int name;
  final int columns;
  final int rows;

  Room({
    this.id,
    this.cinema,
    this.name,
    this.columns,
    this.rows,
  });

  Room.fromMap(String id, Map snapshot)
      : id = id ?? '',
        cinema = snapshot['cinema'],
        name = snapshot['name'],
        columns = snapshot['columns'],
        rows = snapshot['rows'];
}
