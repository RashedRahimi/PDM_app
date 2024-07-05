class PatientModel {
  final String id;
  final String name;

  const PatientModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
      };

  factory PatientModel.fromMap(Map<String, dynamic> map) => PatientModel(
        id: map['id'],
        name: map['name'],
      );

  PatientModel copyWith({
    String? id,
    String? name,
    String? email,
  }) =>
      PatientModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return name;
  }
}
