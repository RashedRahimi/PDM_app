import 'package:flutter/material.dart';
import 'package:pdm_app/models/session_model.dart';

class PatientSessionInfo extends StatefulWidget {
  const PatientSessionInfo({super.key, required this.sessionModel});

  final SessionModel sessionModel;
  @override
  State<PatientSessionInfo> createState() => _PatientSessionInfoState();
}

class _PatientSessionInfoState extends State<PatientSessionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Session Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${widget.sessionModel.patientName} (${widget.sessionModel.patientId})'),
              const SizedBox(height: 50),
              Text('Dedeases: ${widget.sessionModel.diseases.join(',')}'),
              const SizedBox(height: 50),
              const Divider(),
              Text('Medicines: ${widget.sessionModel.medicines.join(',')}'),
              const SizedBox(height: 50),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Text(widget.sessionModel.date)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
