import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/services/films.dart';
import 'package:cinema_app/services/rooms.dart';
import 'package:cinema_app/models/schedule.dart';

class FirestoreSchedules {
  final CollectionReference _ref = Firestore.instance.collection('schedules');
  List<Schedule> schedules;

  Future<List<Schedule>> fetchSchedules() async {
    final res = await _ref.getDocuments();
    this.schedules = res.documents.map((doc) {
      return Schedule.fromMap(doc.documentID, doc.data);
    }).toList();
    return schedules;
  }

  static Future<Schedule> getByRef(DocumentReference docRef) async {
    final _scheduleDoc = await docRef.get();
    if (_scheduleDoc == null) return null;
    
    final _data = _scheduleDoc.data;
    _data['film'] = await FirestoreFilms.getByRef(_data['film']);
    _data['room'] = await FirestoreRooms.getByRef(_data['room']);
    return Schedule.fromMap(_scheduleDoc.documentID, _data);
  }
}
