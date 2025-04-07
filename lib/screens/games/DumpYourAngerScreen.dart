import 'package:flutter/material.dart';

class DumpYourAngerScreen extends StatefulWidget {
  @override
  _DumpYourAngerScreenState createState() => _DumpYourAngerScreenState();
}

class _DumpYourAngerScreenState extends State<DumpYourAngerScreen> {
  Offset notePosition = Offset(100, 100);
  bool crushed = false;
  String noteText = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final trashCanPosition = Offset(screenSize.width / 2 - 40, screenSize.height - 150);

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text("Dump Your Anger"),
        backgroundColor: Colors.pink[300],
      ),
      body: Stack(
        children: [
          // Trashcan at the bottom
          Positioned(
            left: trashCanPosition.dx,
            top: trashCanPosition.dy,
            child: DragTarget(
              onAccept: (data) {
                setState(() {
                  crushed = true;
                });
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/trash-can-open.png'),
                );
              },
            ),
          ),

          // Draggable note
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            left: crushed ? screenSize.width / 2 - 30 : notePosition.dx,
            top: crushed ? screenSize.height - 150 : notePosition.dy,
            child: crushed
                ? Image.asset('assets/images/crushed-paper.png', width: 60)
                : Draggable(
                    feedback: _buildNote(),
                    childWhenDragging: Container(),
                    onDragEnd: (details) {
                      setState(() {
                        notePosition = details.offset;
                      });
                    },
                    data: 'note',
                    child: _buildNote(),
                  ),
          ),

          // Text field for writing
          if (!crushed)
            Positioned(
              top: notePosition.dy + 140,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
                ),
                child: TextField(
                  maxLines: 3,
                  onChanged: (val) => noteText = val,
                  decoration: InputDecoration.collapsed(hintText: "Write it out here..."),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNote() {
    
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          noteText.isEmpty ? "Your Anger Here" : noteText,
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
