import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/services/auth.dart';
import 'package:cinema_app/services/schedules.dart';
import 'package:cinema_app/models/ticket.dart';

class FirestoreTickets {
  final CollectionReference _ref = Firestore.instance.collection('tickets');
  final Auth auth = Auth();
  List<Ticket> tickets = [];

  Future<List<Ticket>> fetchTickets() async {
    // Query the user's tickets
    final _user = await auth.getCurrentUser();
    if (_user == null) return [];

    final _res = await _ref.where('user', isEqualTo: _user.uid).getDocuments();

    // Solve references and build ticket's objects
    this.tickets = await Future.wait(
      _res.documents.map((doc) async {
        Map<String, dynamic> _data = doc.data;
        // Query the schedule object
        _data['schedule'] =
            await FirestoreSchedules.getByRef(_data['schedule']);
        _data['snacks'] = Map<String, dynamic>.from(_data['snacks']);
        // Return a Ticket
        return Ticket.fromMap(doc.documentID, _data);
      }).toList(),
    );
    return tickets;
  }
}
