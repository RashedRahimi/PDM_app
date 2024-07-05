import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdm_app/models/patient_model.dart';
import 'package:pdm_app/models/session_model.dart';
import 'package:pdm_app/repository/patient_repo.dart';
import 'package:pdm_app/repository/session_repo.dart';
import 'package:pdm_app/utils/context_extension.dart';
import 'package:intl/intl.dart';

class AddSession extends StatefulWidget {
  const AddSession({super.key, required this.isEdit, this.sessionModel});
  final bool isEdit;
  final SessionModel? sessionModel;
  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  final diseasesController = TextEditingController();
  final medicinesController = TextEditingController();
  final patientRepo = PatientRepository();
  PatientModel? selectedPetient;

  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      selectedPetient = PatientModel(
          id: widget.sessionModel!.patientId,
          name: widget.sessionModel!.patientId);
      diseasesController.text = widget.sessionModel?.diseases.join(',') ?? '';
      medicinesController.text = widget.sessionModel?.medicines.join(',') ?? '';
      selectedDate = DateFormat('dd-MM-yyyy').parse(widget.sessionModel!.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Session Info'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isEdit) {
            final session = widget.sessionModel!.copyWith(
              patientName: selectedPetient!.name,
              patientId: selectedPetient!.id,
              diseases: diseasesController.text.split(','),
              date: DateFormat('dd-MM-yyyy').format(selectedDate),
              medicines: medicinesController.text.split(','),
            );
            updateSession(context, session);
          } else {
            if (selectedPetient != null) {
              final session = SessionModel(
                id: Random().nextInt(6000000).toString(),
                patientName: selectedPetient!.name,
                patientId: selectedPetient!.id,
                diseases: diseasesController.text.split(','),
                date: DateFormat('dd-MM-yyyy').format(selectedDate),
                medicines: medicinesController.text.split(','),
              );
              addSession(context, session);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please Select a Patient')));
            }
          }
        },
        child: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: context.screenWidth,
                child: StreamBuilder(
                  stream: patientRepo.readPatients(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      final patientList = snapshot.data!.docs
                          .map((doc) => PatientModel.fromMap(doc.data()))
                          .toList();

                      return DropdownButtonHideUnderline(
                        child: DropdownButton<PatientModel>(
                          focusColor: Colors.transparent,
                          menuMaxHeight: context.screenHeight / 2,
                          value: selectedPetient,
                          hint: const Text('Select A Patient'),
                          items: patientList.map((option) {
                            return DropdownMenuItem<PatientModel>(
                              value: option,
                              child: Text('${option.name} (${option.id})',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  textAlign: TextAlign.center),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedPetient = value;
                            });
                          },
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 50),
              textFiled('Diseases', diseasesController),
              const SizedBox(height: 50),
              textFiled('Medicines', medicinesController),
              const SizedBox(height: 30),
              Row(
                children: [
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_month)),
                  Text(DateFormat('dd-MM-yyyy').format(selectedDate))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget textFiled(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: controller,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Please Seprate with comma ( , )',
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Future<void> addSession(
      BuildContext context, SessionModel sessionModel) async {
    final sessionRepo = SessionRepository();

    sessionRepo.addSession(sessionModel: sessionModel).whenComplete(() {
      clear();
      Navigator.pop(context);
    });
  }

  Future<void> updateSession(
      BuildContext context, SessionModel sessionModel) async {
    final sessionRepo = SessionRepository();

    sessionRepo.updateSession(sessionModel: sessionModel).whenComplete(() {
      clear();
      Navigator.pop(context);
    });
  }

  void clear() {
    diseasesController.clear();
    medicinesController.clear();
    selectedDate = DateTime.now();
    selectedPetient = null;
  }
}
