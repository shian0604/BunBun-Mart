import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String userId; // 🔗 Reference to the user
  final String recipient;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.userId,
    required this.recipient,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = false,
  });

  static AddressModel empty() => AddressModel(
    id: '',
    userId: '',
    recipient: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
  );

  // Convert to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'recipient': recipient,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': dateTime ?? DateTime.now(),
      'selectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      recipient: data['recipient'] as String,
      phoneNumber: data['phoneNumber'] as String,
      street: data['street'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      postalCode: data['postalCode'] as String,
      country: data['country'] as String,
      dateTime: (data['dateTime'] as Timestamp?)?.toDate(),
      selectedAddress: data['selectedAddress'] ?? false,
    );
  }

  // Factory constructor to create an AddressModel from Document Snapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      userId: data['userId'] ?? '',
      recipient: data['recipient'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      dateTime: (data['dateTime'] as Timestamp?)?.toDate(),
      selectedAddress: data['selectedAddress'] ?? false,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country ';
  }
}

extension AddressFormatting on AddressModel {
  String toFormattedString() {
    return 'Recipient: $recipient, Phone number: $phoneNumber, '
        'Address: $street, $city, $state, $postalCode, $country';
  }
}
