import 'package:cloud_firestore/cloud_firestore.dart';

class Cinema {
  final String id;
  final int cap;
  final String city;
  final String number;
  final String phone;
  final GeoPoint position;
  final String street;

  Cinema({
    this.id,
    this.cap,
    this.city,
    this.number,
    this.phone,
    this.position,
    this.street,
  });

  Cinema.fromMap(String id, Map snapshot)
      : id = id ?? '',
        cap = snapshot['cap'] ?? 0,
        city = snapshot['city'] ?? '',
        number = snapshot['number'] ?? '',
        phone = snapshot['phone'] ?? '',
        position = snapshot['position'] ?? GeoPoint(0.0, 0.0),
        street = snapshot['street'] ?? '';

  toJson() => {
        "cap": cap,
        "city": city,
        "number": number,
        "phone": phone,
        "position": position,
        "street": street,
      };

  String getAddress() {
    return "$street, $number, ${cap.toString().padLeft(5, '0')}, $city";
  }
}
