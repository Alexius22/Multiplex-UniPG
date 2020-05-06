import 'schedule.dart';

class Ticket {
  final String id;
  final Schedule schedule;
  final int row;
  final int seat;
  final List<TicketSnack> snacks;

  Ticket({
    this.id,
    this.schedule,
    this.row,
    this.seat,
    this.snacks,
  });

  Ticket.fromMap(String id, Map snapshot)
      : id = id ?? '',
        schedule = snapshot['schedule'],
        row = snapshot['row'],
        seat = snapshot['seat'],
        snacks = _snacksExplode(snapshot['snacks']);

  static List<TicketSnack> _snacksExplode(Map<String, dynamic> prova) {
    List<TicketSnack> out = [];

    prova.forEach(
      (String name, dynamic sizeQuantity) {
        sizeQuantity.forEach(
          (String size, quantity) => out.add(
            TicketSnack(name, size, quantity as int),
          ),
        );
      },
    );

    return out;
  }
}

class TicketSnack {
  String name;
  String size;
  int quantity;

  TicketSnack(this.name, this.size, this.quantity);
}
