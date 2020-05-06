import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cinema_app/models/film.dart';

class FirestoreFilms {
  final CollectionReference _ref = Firestore.instance.collection('films');
  List<Film> films;

  Future<List<Film>> fetchFilms() async {
    final res = await _ref.getDocuments();
    this.films = await Future.wait(
      res.documents
          .map(
            (doc) async => Film.fromMap(
              doc.documentID,
              await _solveDataRefs(doc.data),
            ),
          )
          .toList(),
    );
    return films;
  }

  static Future<Map> _solveDataRefs(data) async {
    // Get genres name
    List<String> _genres = [];
    for (final _genreRef in data['genres']) {
      final DocumentSnapshot _genreDoc = await _genreRef.get();
      _genres.add(_genreDoc.data['name']);
    }
    data['genres'] = _genres;

    // Get poster image URL
    data['image'] = await FirebaseStorage()
        .ref()
        .child('posters/' + data['image'])
        .getDownloadURL();
    return data;
  }

  static Future<Film> getByRef(DocumentReference docRef) async {
    final _filmDoc = await docRef.get();
    if (_filmDoc == null) return null;
    return Film.fromMap(
        _filmDoc.documentID, await _solveDataRefs(_filmDoc.data));
  }
}
