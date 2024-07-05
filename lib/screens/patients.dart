import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdm_app/models/patient_model.dart';
import 'package:pdm_app/repository/patient_repo.dart';
import 'package:pdm_app/screens/add_patient.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final patientRepo = PatientRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPatient(isEdit: false)));
              },
              icon: const Icon(Icons.person_add)),
        ],
      ),
      body: StreamBuilder(
        stream: patientRepo.readPatients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final patientList = snapshot.data!.docs
                .map((doc) => PatientModel.fromMap(doc.data()))
                .toList();

            return ListView.builder(
                itemCount: patientList.length,
                itemBuilder: (context, index) {
                  final patient = patientList[index];
                  return ListTile(
                    title: Text(patient.name),
                    subtitle: Text(patient.id),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPatient(
                                        isEdit: true,
                                        patientModel: patient,
                                      )));
                        },
                        icon: const Icon(Icons.edit)),
                  );
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
