import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_version_one/models/professional_contacts.dart';
import 'package:kira_version_one/widgets/display_info_medical.dart';

class MedicalContactsListScreen extends StatefulWidget {
  @override
  _MedicalContactsListScreenState createState() =>
      _MedicalContactsListScreenState();
}

class _MedicalContactsListScreenState extends State<MedicalContactsListScreen> {
  List<Professional> professionals = [];

  @override
  void initState() {
    super.initState();
    loadContactsFromJson();
  }

  Future<void> loadContactsFromJson() async {
    final String response =
        await rootBundle.loadString('assets/sources/medical_contacts.json');
    final data = json.decode(response) as List;
    setState(() {
      professionals = data.map((item) => Professional.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Health Professionals"),
        backgroundColor: Color(0xFFB3E5FC),
        foregroundColor: Colors.black,
      ),
      body: professionals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: professionals.length,
              itemBuilder: (context, index) {
                final professional = professionals[index];

                final String name = professional.name;
                final String city =
                    professional.location['city'] ?? 'Location not available';
                final String specialty = professional.specializations.isNotEmpty
                    ? professional.specializations.first
                    : 'Specialization not listed';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalContactDetailsScreen(professional: professional),

                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color(0xFFE1F5FE),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.blueGrey),
                      title: Text(
                        name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text("$specialty\n📍 $city", maxLines: 2),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
