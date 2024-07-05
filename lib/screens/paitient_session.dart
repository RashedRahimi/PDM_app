import 'package:flutter/material.dart';
import 'package:pdm_app/models/session_model.dart';
import 'package:pdm_app/repository/session_repo.dart';
import 'package:pdm_app/screens/add_session.dart';
import 'package:pdm_app/screens/patient_session_info.dart';
import 'package:pdm_app/screens/patients.dart';

class PatientSesionList extends StatefulWidget {
  const PatientSesionList({super.key});

  @override
  State<PatientSesionList> createState() => _PatientSesionListState();
}

class _PatientSesionListState extends State<PatientSesionList> {
  final sessionRepo = SessionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDM'),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddSession(isEdit: false))),
                icon: const Icon(Icons.assignment_add)),
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientPage())),
                icon: const Icon(Icons.list_alt)),
          ],
        ),
        body: StreamBuilder(
          stream: sessionRepo.readsessions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              final sessiontList = snapshot.data!.docs
                  .map((doc) => SessionModel.fromMap(doc.data()))
                  .toList();
              return ListView.separated(
                  itemCount: sessiontList.length,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final session = sessiontList[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientSessionInfo(sessionModel: session))),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(session.patientName),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddSession(
                                                        isEdit: true,
                                                        sessionModel:
                                                            session))),
                                        icon: const Icon(Icons.edit)),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          sessionRepo.deleteSessiont(
                                              sessionModel: session);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(session.patientId),
                            trailing: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(Icons.calendar_month),
                                  const SizedBox(width: 5),
                                  Text(session.date),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
