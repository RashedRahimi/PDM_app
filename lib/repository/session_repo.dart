import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdm_app/models/session_model.dart';

class SessionRepository {
  final _sessionCollection = FirebaseFirestore.instance.collection('sessions');

  Future<void> addSession({required SessionModel sessionModel}) async {
    try {
      await _sessionCollection.doc(sessionModel.id).set(sessionModel.toMap());
    } catch (error) {
      debugPrint('Error $error');
      rethrow;
    }
  }

  Future<void> updateSession({required SessionModel sessionModel}) async {
    try {
      await _sessionCollection
          .doc(sessionModel.id)
          .update(sessionModel.toMap());
    } catch (error) {
      debugPrint('Error $error');
      rethrow;
    }
  }

  Future<void> deleteSessiont({required SessionModel sessionModel}) async {
    try {
      await _sessionCollection.doc(sessionModel.id).delete();
    } catch (error) {
      debugPrint('Error $error');
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readsessions() {
    return _sessionCollection.snapshots();
  }
}
