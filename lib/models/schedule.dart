import 'film.dart';
import 'room.dart';

class Schedule {
  final String id;
  final DateTime dateTime;
  final Film film;
  final Room room;
  final String shotTypology;

  Schedule({
    this.id,
    this.dateTime,
    this.film,
    this.room,
    this.shotTypology,
  });

  Schedule.fromMap(String id, Map snapshot)
      : id = id ?? '',
        dateTime = snapshot['dateTime'].toDate(),
        film = snapshot['film'],
        room = snapshot['room'],
        shotTypology = snapshot['shotTypology'];
}
