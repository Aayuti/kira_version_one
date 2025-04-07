import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class CreativeCorner extends StatefulWidget {
  @override
  _CreativeCornerState createState() => _CreativeCornerState();
}

class _CreativeCornerState extends State<CreativeCorner> {
  late SignatureController _controller;
  Color selectedColor = Colors.black;
  double strokeWidth = 4.0;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: strokeWidth,
      penColor: selectedColor,
    );
  }

  void _updateController() {
    final oldController = _controller;
    _controller = SignatureController(
      penStrokeWidth: strokeWidth,
      penColor: selectedColor,
      points: oldController.points,
    );
    oldController.dispose();
    setState(() {});
  }

  void _changeColor(Color color) {
    selectedColor = color;
    _updateController();
  }

  void _changeStroke(double width) {
    strokeWidth = width;
    _updateController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creative Corner'),
        backgroundColor: Colors.pink.shade100,
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () => _controller.undo(),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _controller.clear(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildColorPicker(Colors.black),
                _buildColorPicker(Colors.red),
                _buildColorPicker(Colors.blue),
                _buildColorPicker(Colors.green),
                _buildStrokeSlider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () => _changeColor(color),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 14,
        child: selectedColor == color ? Icon(Icons.check, color: Colors.white, size: 16) : null,
      ),
    );
  }

  Widget _buildStrokeSlider() {
    return Row(
      children: [
        Icon(Icons.brush, size: 20),
        Slider(
          value: strokeWidth,
          min: 1,
          max: 10,
          divisions: 9,
          label: strokeWidth.round().toString(),
          onChanged: _changeStroke,
        ),
      ],
    );
  }
}
