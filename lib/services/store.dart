import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  static const String _example = 'examples';

  // add new user
  static Future<void> initUser(String fullName) async {
    String uid = Auth().getUserId();
    try {
      UserModel user = UserModel(
        id: uid,
        fullName: fullName,
        listLesson: [],
      );
      final docRef = _db.collection(_userPath).add(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // load user data
  static Future<UserModel> loadUser() async {
    String uid = Auth().getUserId();
    final docRef = _db.collection(_userPath).doc(uid);
    Map<String, dynamic> data = await _getDoc(docRef);
    UserModel user = UserModel.fromJson(data);
    return user;
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
