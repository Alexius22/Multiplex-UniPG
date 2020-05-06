import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/models/cinema.dart';

class FirestoreCinemas {
  final CollectionReference _ref = Firestore.instance.collection('cinemas');
  List<Cinema> cinemas;

  Future<List<Cinema>> fetchCinemas() async {
    final res = await _ref.getDocuments();
    this.cinemas = res.documents
        .map((doc) => Cinema.fromMap(doc.documentID, doc.data))
        .toList();
    return cinemas;
  }

  static Future<Cinema> getByRef(DocumentReference docRef) async {
    final _cinemaDoc = await docRef.get();
    if (_cinemaDoc == null) return null;

    return Cinema.fromMap(_cinemaDoc.documentID, _cinemaDoc.data);
  }

  Future<List<String>> getCinemasCities() async {
    if (cinemas == null) await fetchCinemas();
    return cinemas.map((cinema) => cinema.city).toList();
  }

  Future<Cinema> getCinemaByCity(String city) async {
    if (cinemas == null) await fetchCinemas();
    for (Cinema cin in cinemas) if (cin.city == city) return cin;
    return null;
  }
}
