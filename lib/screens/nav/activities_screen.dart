import 'package:flutter/material.dart';
import 'package:kira_version_one/screens/games/DumpYourAngerScreen.dart';

class ActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Bright lightest sky blue
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Motivational Quote at the top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Text(
              '“Let it out, let it go!”',
              style: TextStyle(
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: Colors.green[900],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          // Horizontal list of 5 circular containers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // First Container (with icon and pastel look)
                  _buildAngerContainer(
                    context: context,
                    color: Colors.pink[100]!,  // Pastel pink
                    icon: 'assets/images/trash-can-open.png',  // Trash can icon
                  ),
                  const SizedBox(width: 15),
                  
                  // Second Container (with icon and pastel look)
                  _buildAngerContainer(
                    context: context,
                    color: Colors.green[100]!,  // Pastel green
                    icon: 'assets/images/diary.png', // Replace with your icon
                  ),
                  const SizedBox(width: 15),
                  
                  // Third Container (with icon and pastel look)
                  _buildAngerContainer(
                    context: context,
                    color: Colors.blue[100]!,  // Pastel blue
                    icon: 'assets/images/musical-note.png', // Replace with your icon
                  ),
                  const SizedBox(width: 15),
                  
                  // Fourth Container (with icon and pastel look)
                  _buildAngerContainer(
                    context: context,
                    color: Colors.yellow[100]!,  // Pastel yellow
                    icon: 'assets/images/meditation.png', // Replace with your icon
                  ),
                  const SizedBox(width: 15),
                  
                  // Fifth Container (with icon and pastel look)
                  _buildAngerContainer(
                    context: context,
                    color: Colors.purple[100]!,  // Pastel purple
                    icon: 'assets/images/console.png', // Replace with your icon
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create each container
  Widget _buildAngerContainer({
    required BuildContext context,
    required Color color, 
    required String icon,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle the action for tapping (e.g., navigate to the next screen)
        print("hello");
        if (icon == 'assets/images/trash-can-open.png') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DumpYourAngerScreen()),
      );
      }},
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(0.3), // Subtle border
            width: 2,  // Border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: 40,  // Adjusted icon size for better fit
            height: 40, // Adjusted icon size for better fit
          ),
        ),
      ),
    );
  }
}
