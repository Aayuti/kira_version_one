import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_version_one/models/professional_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:kira_version_one/models/professional_contacts.dart'; // Make sure to import the model

class MedicalContactDetailsScreen extends StatelessWidget {
  final Professional professional;

  const MedicalContactDetailsScreen({Key? key, required this.professional})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = professional.name ?? 'Unknown';
    final String pronouns = professional.pronouns ?? '';
    final String age = professional.age.toString() ?? 'N/A';
    final String experience = professional.experience ?? 'N/A';
    final List<dynamic> specializations = professional.specializations ?? [];
    final String phone = professional.contact['phone'] ?? 'Not provided';
    final String email = professional.contact['email'] ?? 'Not provided';
    final List<dynamic> languages = professional.languagesSpoken ?? [];
    final List<dynamic> sessionMedium = professional.sessionMedium ?? [];
    final String city = professional.location['city'] ?? 'Unknown';
    final String area = professional.location['area'] ?? 'Unknown';
    final String fee = professional.fee?.toString() ?? '0';
    final String duration = professional.sessionDuration ?? 'N/A';
    final List<dynamic> qualifications = professional.qualifications ?? [];
    final String notes = professional.notes ?? '';
    final String profileUrl = professional.profileUrl ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Color(0xFFB3E5FC),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE1F5FE),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_hospital, size: 40, color: Colors.blueGrey),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (pronouns.isNotEmpty)
                          Text(
                            "($pronouns)",
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildSectionCard("Basic Info", [
              _buildInfoRow("Age", age),
              _buildInfoRow("Experience", experience),
            ]),
            _buildSectionCard("Location & Sessions", [
              _buildInfoRow("City", city),
              _buildInfoRow("Area", area),
              _buildInfoRow("Session Medium", sessionMedium.join(", ")),
              _buildInfoRow("Session Duration", duration),
              _buildInfoRow("Fee", "₹$fee"),
            ]),
            _buildSectionCard("Contact", [
              _buildInfoRow("Phone", phone),
              _buildInfoRow("Email", email),
            ]),
            _buildSectionCard("Languages Spoken", [
              _buildBulletList(languages),
            ]),
            _buildSectionCard("Specializations", [
              _buildBulletList(specializations),
            ]),
            _buildSectionCard("Qualifications", [
              _buildBulletList(qualifications),
            ]),
            _buildSectionCard("Notes", [
              Text(
                notes,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ]),
            SizedBox(height: 20),
            _buildProfileButton(context, profileUrl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFFB3E5FC), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletList(List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• ", style: TextStyle(fontSize: 16)),
            Expanded(
              child: Text(
                item.toString(),
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildProfileButton(BuildContext context, String url) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          _launchProfileUrl(url);
        },
        icon: Icon(Icons.link),
        label: Text("View Full Profile"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF81D4FA),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> _launchProfileUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // 🔥 Force external browser
      );
      if (!launched) {
        debugPrint('Failed to launch $url');
        _showErrorToast(); // Optional: show error to user
      }
    } else {
      debugPrint("Cannot launch URL: $url");
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    // You can replace this with a Flutter toast/snackbar
    print("❌ Could not open the profile link");
  }
}
