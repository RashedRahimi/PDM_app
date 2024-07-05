import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdm_app/models/patient_model.dart';

class PatientRepository {
  final _patientCollection = FirebaseFirestore.instance.collection('patients');

  Future<void> addPatient({required PatientModel patientModel}) async {
    try {
      await _patientCollection.doc(patientModel.id).set(patientModel.toMap());
    } catch (error) {
      debugPrint('Error $error');
      rethrow;
    }
  }

  Future<void> updatePatient({required PatientModel patientModel}) async {
    try {
      await _patientCollection
          .doc(patientModel.id)
          .update(patientModel.toMap());
    } catch (error) {
      debugPrint('Error $error');
      rethrow;
    }
  }

  Future<void> deletePatient({required PatientModel patientModel}) async {
    try {
      await _patientCollection.doc(patientModel.id).delete();
    } catch (error) {
      debugPrint('Error $error');
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readPatients() {
    return _patientCollection.snapshots();
  }
}
