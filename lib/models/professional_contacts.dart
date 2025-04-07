class Professional {
  final String name;
  final String pronouns;
  final int age;
  final String experience;
  final List<String> specializations;
  final Map<String, String> contact;
  final List<String> languagesSpoken;
  final List<String> sessionMedium;
  final Map<String, String> location;
  final dynamic fee;
  final String sessionDuration;
  final List<String> qualifications;
  final String? notes;
  final String profileUrl;

  Professional({
    required this.name,
    required this.pronouns,
    required this.age,
    required this.experience,
    required this.specializations,
    required this.contact,
    required this.languagesSpoken,
    required this.sessionMedium,
    required this.location,
    required this.fee,
    required this.sessionDuration,
    required this.qualifications,
    this.notes,
    required this.profileUrl,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
  // Ensure contact map is all strings
  final contact = Map<String, dynamic>.from(json['contact']);
  final stringifiedContact = contact.map((key, value) => MapEntry(key, value.toString()));

  // Ensure location map is all strings
  final location = Map<String, dynamic>.from(json['location']);
  final stringifiedLocation = location.map((key, value) => MapEntry(key, value.toString()));

  return Professional(
    name: json['name'],
    pronouns: json['pronouns'],
    age: json['age'],
    experience: json['experience'],
    specializations: List<String>.from(json['specializations']),
    contact: stringifiedContact,
    languagesSpoken: List<String>.from(json['languages_spoken']),
    sessionMedium: List<String>.from(json['session_medium']),
    location: stringifiedLocation,
    fee: json['fee'], // keep as dynamic for now
    sessionDuration: json['session_duration'],
    qualifications: List<String>.from(json['qualifications']),
    notes: json['notes'],
    profileUrl: json['profile_url'],
  );
}

}
