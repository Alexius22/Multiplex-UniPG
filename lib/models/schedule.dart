import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'film.dart';
import 'room.dart';

class Schedule {
  final String id;
  final DateTime dateTime;
  final Film film;
  final Room room;
  final List<Point<int>> seatsOccupied;
  final String shotTypology;

  Schedule({
    this.id,
    this.dateTime,
    this.film,
    this.room,
    this.seatsOccupied,
    this.shotTypology,
  });

  Schedule.fromMap(String id, Map snapshot)
      : id = id ?? '',
        // Dirty to fix to accomodate firebase datetime storage format
        dateTime = snapshot['dateTime'].toDate().add(Duration(hours: 2)),
        film = snapshot['film'],
        room = snapshot['room'],
        seatsOccupied = List<GeoPoint>.from(snapshot['seatsOccupied'])
            .map(
              (GeoPoint p) => Point<int>(
                p.latitude.toInt(),
                p.longitude.toInt(),
              ),
            )
            .toList(),
        shotTypology = snapshot['shotTypology'];
}
