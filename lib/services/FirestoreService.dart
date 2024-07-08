import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/LessonModel.dart';
import '../models/UserModel.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create or Update a User
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toJson());
  }

  // Create or Update a Story
  Future<void> createOrUpdateStory(String docId, String story) async {
    DocumentReference docRef = _db.collection('lessons').doc(docId);

    return _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);

      if (snapshot.exists) {
        // Update the existing document
        transaction.update(docRef, {'story': story});
      } else {
        // Create a new document
        transaction.set(docRef, {'story': story});
      }
    });
  }

  // Read a User by ID
  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot doc = await _db.collection('users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update a User
  Future<void> updateUser(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toJson());
  }

  // Delete a User
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }

  // Add a Lesson to a User
  Future<void> addLesson(String userId, LessonModel lesson) async {
    DocumentReference userRef = _db.collection('users').doc(userId);
    DocumentSnapshot userDoc = await userRef.get();
    if (userDoc.exists) {
      List<LessonModel> lessons =
          (userDoc.data() as Map<String, dynamic>)['listLesson']
              .map<LessonModel>((e) => LessonModel.fromJson(e))
              .toList();
      lessons.add(lesson);
      await userRef
          .update({'listLesson': lessons.map((e) => e.toJson()).toList()});
    }
  }

  // Remove a Lesson from a User
  Future<void> removeLesson(String userId, String lessonTitle) async {
    DocumentReference userRef = _db.collection('users').doc(userId);
    DocumentSnapshot userDoc = await userRef.get();
    if (userDoc.exists) {
      List<LessonModel> lessons =
          (userDoc.data() as Map<String, dynamic>)['listLesson']
              .map<LessonModel>((e) => LessonModel.fromJson(e))
              .toList();
      lessons.removeWhere((lesson) => lesson.title == lessonTitle);
      await userRef
          .update({'listLesson': lessons.map((e) => e.toJson()).toList()});
    }
  }
  // Example method to get a document reference
  DocumentReference getDocumentRef(String docId) {
    return _db.collection('lessons').doc(docId);
  }
}
