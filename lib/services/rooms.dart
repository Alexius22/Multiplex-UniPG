import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/services/cinemas.dart';
import 'package:cinema_app/models/room.dart';

class FirestoreRooms {
  final CollectionReference _ref = Firestore.instance.collection('rooms');
  List<Room> rooms;

  Future<List<Room>> fetchRooms() async {
    final res = await _ref.getDocuments();
    this.rooms = res.documents.map((doc) {
      return Room.fromMap(doc.documentID, doc.data);
    }).toList();
    return rooms;
  }

  static Future<Room> getByRef(DocumentReference docRef) async {
    final _roomDoc = await docRef.get();
    if (_roomDoc == null) return null;
    
    final _data = _roomDoc.data;
    _data['cinema'] = await FirestoreCinemas.getByRef(_data['cinema']);
    return Room.fromMap(_roomDoc.documentID, _data);
  }
}
