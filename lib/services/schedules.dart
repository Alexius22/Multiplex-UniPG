import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/services/films.dart';
import 'package:cinema_app/services/rooms.dart';
import 'package:cinema_app/models/schedule.dart';

class FirestoreSchedules {
  final CollectionReference _ref = Firestore.instance.collection('schedules');
  List<Schedule> schedules;

  Future<List<Schedule>> fetchSchedules(String city) async {
    final res = await _ref.orderBy('dateTime').getDocuments();
    this.schedules = await Future.wait(
      res.documents
          .map(
            (doc) async => Schedule.fromMap(
              doc.documentID,
              await _solveDataRefs(doc.data),
            ),
          )
          .toList(),
    );

    final List<Schedule> _out = [];
    for (Schedule s in schedules) if (s.room.cinema.city == city) _out.add(s);

    return _out;
  }

  static Future<Map> _solveDataRefs(data) async {
    // Get film informations
    data['film'] = await FirestoreFilms.getByRef(data['film']);
    data['room'] = await FirestoreRooms.getByRef(data['room']);
    return data;
  }

  static Future<Schedule> getByRef(DocumentReference docRef) async {
    final _scheduleDoc = await docRef.get();
    if (_scheduleDoc == null) return null;
    return Schedule.fromMap(
        _scheduleDoc.documentID, await _solveDataRefs(_scheduleDoc.data));
  }

  Future<void> updateSeatsOccupied(Schedule s, List<Point<int>> newSeats) async {
    // Convert seats to firestore form
    List<GeoPoint> firestoreSeats = newSeats
        .map(
            (Point<int> seat) => GeoPoint(seat.x.toDouble(), seat.y.toDouble()))
        .toList();

    // Update firestore DB
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot snapshot = await tx.get(_ref.document(s.id));
      await tx.update(snapshot.reference, <String, dynamic>{
        'seatsOccupied': FieldValue.arrayUnion(firestoreSeats)
      });
    });
  }
}
