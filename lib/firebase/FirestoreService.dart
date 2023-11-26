// // firestore_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');

//   Future<void> saveFavoritePlace(String userId, Map<String, dynamic> place) {
//     return usersCollection.doc(userId).collection('favorites').add(place);
//   }

//   Future<void> saveComment(String userId, String placeId, String comment) {
//     return usersCollection.doc(userId).collection('comments').doc(placeId).set({
//       'comment': comment,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
// }
