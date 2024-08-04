import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/GlobalData.dart';
import 'package:english_app/Widgets/MyToast.dart';
import 'package:english_app/common/ConstantModel.dart';
import 'package:english_app/models/LessonModel.dart';
import 'package:english_app/services/Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/UserModel.dart';
import 'auth.dart';

class FireStore {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static const String _userPath = "users";

  static final CollectionReference<Map<String, dynamic>> _users =
      _db.collection(_userPath);

  // add new user
  static Future<void> initUser(String fullName, String email) async {
    try {
      String uid = Auth().getUserId();
      final docRef = _db.collection(_userPath).doc(uid);
      UserModel user = UserModel.init(fullName, email);
      docRef.set(user.toJson());

      await initLesson();
    } catch (e) {
      rethrow;
    }
  }

  static Future initLesson() async {
    String uid = Auth().getUserId();
    final docRef = _db.collection(_userPath).doc(uid);
    // push data to firebase
    List<LessonModel> result = await Helper().buildDefaultLesson();
    for (var e in result) {
      docRef.collection(LIST_DEFAULT_LESSON).add(e.toJson());
    }
  }

  // load user data
  static Future loadUser() async {
    String uid = Auth().getUserId();
    final docRef = _db.collection(_userPath).doc(uid);
    Map<String, dynamic> data = await _getDoc(docRef);
    UserModel user = UserModel.fromJson(data);
    GlobalData.user = UserModel.clone(user);
    log(GlobalData.user.toString());
  }

  static Future loadLesson() async {
    String uid = Auth().getUserId();
    var docRef = _users.doc(uid).collection(LIST_PERSONAL_LESSON);
    List<Map<String, dynamic>> data = await _listDocs(docRef);
    GlobalData.listPersonalLesson =
        data.map<LessonModel>((e) => LessonModel.fromJson(e)).toList();

    docRef = _users.doc(uid).collection(LIST_DEFAULT_LESSON);
    data = await _listDocs(docRef);
    GlobalData.listDefaultLesson =
        data.map<LessonModel>((e) => LessonModel.fromJson(e)).toList();
  }

  // add an new lesson
  static Future<bool> addLesson(LessonModel lesson) async {
    // Check for duplicates locally
    if (GlobalData.isExistLesson(lesson.id)) {
      log('Lesson with ID ${lesson.id} already exists locally');
      return false;
    }

    try {
      // Add locally
      GlobalData.listPersonalLesson.add(lesson);

      // Add to Firebase
      String uid = Auth().getUserId();
      final docRef =
          _users.doc(uid).collection(LIST_PERSONAL_LESSON).doc(lesson.id);
      await _addDoc(docRef, lesson.toJson());

      return true;
    } catch (e) {
      log('Failed to add lesson: $e');
      return false;
    }
  }

  // update story for a specific lesson
  static Future<void> updateStory(String lessonId, String story) async {
    log("lessonId: $lessonId");
    // update local
    GlobalData.addStoryToLessonById(lessonId, story);

    // cloud
    try {
      String uid = Auth().getUserId();
      final docRef =
          _users.doc(uid).collection(LIST_PERSONAL_LESSON).doc(lessonId);
      _setDoc(docRef, {'story': story});
    } catch (e) {
      showToast(e.toString());
    }
  }

  // update latestOpenedDate by id
  static Future<void> updateLatestOpenedDateById(
      String lessonId, String date) async {
    log("lessonId: $lessonId");
    // update local
    GlobalData.updateLatestOpenedDateById(lessonId, date);

    // cloud
    try {
      String uid = Auth().getUserId();
      final docRef =
          _users.doc(uid).collection(LIST_PERSONAL_LESSON).doc(lessonId);
      _setDoc(docRef, {'latestOpenedDate': date});
    } catch (e) {
      showToast(e.toString());
    }
  }

  // update isFavorite by id
  static Future<void> updateIsFavoriteById(String lessonId) async {
    log("lessonId: $lessonId");
    // update local
    GlobalData.updateISFavoriteById(lessonId);

    // cloud
    try {
      String uid = Auth().getUserId();
      final docRef =
          _users.doc(uid).collection(LIST_PERSONAL_LESSON).doc(lessonId);
      final snapshot = await _getDoc(docRef);
      bool isFav = snapshot['isFavorite'];
      _setDoc(docRef, {'isFavorite': !isFav});
    } catch (e) {
      showToast(e.toString());
    }
  }

  // update lesson
  static Future<void> updateLesson(LessonModel newModel) async {
    // update local
    GlobalData.updateLesson(newModel);

    // cloud
    try {
      String uid = Auth().getUserId();
      final docRef =
          _users.doc(uid).collection(LIST_PERSONAL_LESSON).doc(newModel.id);
      _setDoc(docRef, newModel.toJson());
      showToast("Update successfully");
    } catch (e) {
      showToast(e.toString());
    }
  }

  // remove lesson by id
  static Future<bool> removeLessonById(String lessonId) async {
    log("id: $lessonId");
    // remove local
    GlobalData.removeLessonById(lessonId);

    // remove cloud
    try {
      String uid = Auth().getUserId();
      final docRef =
          _users.doc(uid).collection(LIST_PERSONAL_LESSON).doc(lessonId);
      await docRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // ##### Utility ##### //

  static Future<Map<String, dynamic>> _getDoc(
    DocumentReference docRef,
  ) async {
    try {
      DocumentSnapshot doc = await docRef.get();

      Map<String, dynamic> result = doc.data() as Map<String, dynamic>;

      return result;
    } on Exception catch (error, stackTrace) {
      log(
        'Exception when try to read ${docRef.path}',
        error: error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> _listDocs(
    CollectionReference colRef,
  ) async {
    try {
      final query = await colRef.get();

      List<Map<String, dynamic>> results =
          query.docs.map((QueryDocumentSnapshot<Object?> e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        data['id'] = e.id;
        return data;
      }).toList();

      return results;
    } on Exception catch (error, stackTrace) {
      log(
        'Exception when try to list ${colRef.path}',
        error: error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  static Future<void> _addDoc(
    DocumentReference docRef,
    Map<String, dynamic> data,
  ) async {
    if (await _docExists(docRef)) {
      _logWarning('Trying to create existing document ${docRef.path}');
      return;
    }

    try {
      await docRef.set(data);
    } on Exception catch (error, stackTrace) {
      log(
        'Exception when try to create ${docRef.path}',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  static Future<void> _setDoc(
    DocumentReference docRef,
    Map<String, dynamic> data, {
    bool merge = true,
  }) async {
    if (await _docNotExists(docRef)) {
      _logExceptionAndThrow(
        'Trying to set non-existing document ${docRef.path}',
      );
    }
    try {
      await docRef.set(
        data,
        SetOptions(merge: merge),
      );
    } on Exception catch (error, stackTrace) {
      log(
        'Exception when try to set ${docRef.path}',
        error: error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  static Future<bool> _docExists(
    DocumentReference docRef,
  ) async {
    try {
      DocumentSnapshot doc = await docRef.get();

      return doc.exists;
    } on Exception catch (error, stackTrace) {
      log(
        'Exception when try to read ${docRef.path}',
        error: error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  static Future<bool> _docNotExists(
    DocumentReference docRef,
  ) async {
    return !(await _docExists(docRef));
  }

  static String? _getUserId() {
    User? user = Auth().currentUser;
    if (user != null) {
      String userId = user.uid;
      return userId;
    }
    return null; // or handle the null case in an appropriate way for your application
  }

  static List<int> _getTimestampRange(
    int year, {
    int? monthInYear,
    int? weekInMonth,
  }) {
    DateTime start, end;

    if (monthInYear != null) {
      if (weekInMonth != null) {
        start = DateTime(year, monthInYear, 1 + (weekInMonth - 1) * 7);
        start = start.subtract(Duration(days: start.weekday - 1));
        end = start.add(const Duration(days: 6));
      } else {
        start = DateTime(year, monthInYear);
        end = DateTime(year, monthInYear + 1);
      }
    } else {
      start = DateTime(year);
      end = DateTime(year + 1);
    }

    int startTimestamp = start.millisecondsSinceEpoch;
    int endTimestamp = end.millisecondsSinceEpoch;

    return [startTimestamp, endTimestamp];
  }

  // ##### EVENT HANDLER ##### //

  /// Emit a log event given the exception message and the current stack trace,
  /// then throw the exception
  static void _logExceptionAndThrow(
    String message,
  ) {
    Exception error = Exception(message);
    StackTrace stackTrace = StackTrace.current;

    log(message, error: error, stackTrace: stackTrace);

    throw error;
  }

  /// Emit a log event given the exception message and the current stack trace
  static void _logWarning(
    String message,
  ) {
    log(
      message,
      error: Exception(message),
      stackTrace: StackTrace.current,
    );
  }
}
