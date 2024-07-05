class SessionModel {
  final String id;
  final String patientName;
  final String patientId;

  final List<String> diseases;
  final List<String> medicines;
  final String date;

  const SessionModel({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.diseases,
    required this.medicines,
    required this.date,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'patientName': patientName,
        'patientId': patientId,
        'diseases': diseases,
        'medicines': medicines,
        'date': date,
      };

  factory SessionModel.fromMap(Map<String, dynamic> map) => SessionModel(
        id: map['id'],
        patientName: map['patientName'],
        patientId: map['patientId'],
        diseases: List<String>.from(map['diseases']),
        medicines: List<String>.from(map['medicines']),
        date: map['date'],
      );

  SessionModel copyWith({
    String? id,
    String? patientName,
    String? patientId,
    List<String>? diseases,
    List<String>? medicines,
    String? date,
  }) =>
      SessionModel(
        id: id ?? this.id,
        patientName: patientName ?? this.patientName,
        patientId: patientId ?? this.patientId,
        diseases: diseases ?? this.diseases,
        medicines: medicines ?? this.medicines,
        date: date ?? this.date,
      );
}
