import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/services/films.dart';
import 'package:cinema_app/services/rooms.dart';
import 'package:cinema_app/models/schedule.dart';

class FirestoreSchedules {
  final Query _ref =
      Firestore.instance.collection('schedules').orderBy('dateTime');
  List<Schedule> schedules;

  Future<List<Schedule>> fetchSchedules(String city) async {
    final res = await _ref.getDocuments();
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
}
