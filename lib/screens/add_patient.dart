import 'package:flutter/material.dart';
import 'package:pdm_app/models/patient_model.dart';
import 'package:pdm_app/repository/patient_repo.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key, required this.isEdit, this.patientModel});
  final bool isEdit;
  final PatientModel? patientModel;

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      idController.text = widget.patientModel?.id ?? '';
      nameController.text = widget.patientModel?.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isEdit) {
            final patient =
                widget.patientModel!.copyWith(name: nameController.text);
            updatePatient(context, patient);
          } else {
            final patient =
                PatientModel(id: idController.text, name: nameController.text);
            addPatient(context, patient);
          }
        },
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!widget.isEdit)
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Patient Id',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Patient Name',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPatient(
      BuildContext context, PatientModel patientModel) async {
    final patientRepo = PatientRepository();
    patientRepo.addPatient(patientModel: patientModel).whenComplete(() {
      Navigator.pop(context);
    });
  }

  Future<void> updatePatient(
      BuildContext context, PatientModel patientModel) async {
    final patientRepo = PatientRepository();
    patientRepo.updatePatient(patientModel: patientModel).whenComplete(() {
      Navigator.pop(context);
    });
  }
}
