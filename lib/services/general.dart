import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/models/general.dart';

class FirestoreGeneral {
  final DocumentReference _ref =
      Firestore.instance.collection('general').document('0');

  Future<GeneralInfo> fetchUpdates() async {
    final DocumentSnapshot _res = await _ref.get();
    return GeneralInfo.fromMap(_res.data);
  }
}
