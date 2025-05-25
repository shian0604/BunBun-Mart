import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearch {
  final String id;
  final String keyword;
  final DateTime timestamp;
  final String userId;

  UserSearch({
    required this.id,
    required this.keyword,
    required this.timestamp,
    required this.userId,
  });

  // Returns an empty RecentSearch object
  static UserSearch empty() => UserSearch(
        id: '',
        keyword: '',
        timestamp: DateTime.now(),
        userId: '',
      );

  // Convert a RecentSearch into a map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      'timestamp': Timestamp.fromDate(timestamp),
      'userId': userId,
    };
  }

  // Create a RecentSearch from a Firestore document snapshot
  factory UserSearch.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return UserSearch(
        id: document.id,
        keyword: data['keyword'] ?? '',
        timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
         userId: data['userId'] ?? '',
      );
    } else {
      return UserSearch.empty();
    }
  }
}
