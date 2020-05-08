import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/models/snack.dart';

class FirestoreSnacks {
  final Query _ref =
      Firestore.instance.collection('snacks').orderBy('priceList');
  List<Snack> snacks;

  Future<List<Snack>> fetchSnacks() async {
    final res = await _ref.getDocuments();
    this.snacks = res.documents
        .map((doc) => Snack.fromMap(doc.documentID, doc.data))
        .toList();
    return snacks;
  }
}
