import 'package:flutter/material.dart';
import 'dart:math';

class MemoryBoostGame extends StatefulWidget {
  @override
  _MemoryBoostGameState createState() => _MemoryBoostGameState();
}

class _MemoryBoostGameState extends State<MemoryBoostGame> {
  List<String> _emojis = ['🍎', '🍌', '🍇', '🍉', '🍓', '🍍'];
  List<_CardModel> _cards = [];
  int? _firstSelectedIndex;
  bool _waiting = false;

  @override
  void initState() {
    super.initState();
    _initializeCards();
  }

  void _initializeCards() {
    List<String> allEmojis = [..._emojis, ..._emojis]; // pairs
    allEmojis.shuffle(Random());

    _cards = allEmojis
        .map((emoji) => _CardModel(emoji: emoji, isFaceUp: false, isMatched: false))
        .toList();
  }

  void _onCardTap(int index) {
    if (_waiting || _cards[index].isFaceUp || _cards[index].isMatched) return;

    setState(() {
      _cards[index].isFaceUp = true;
    });

    if (_firstSelectedIndex == null) {
      _firstSelectedIndex = index;
    } else {
      int secondIndex = index;
      _waiting = true;

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          if (_cards[_firstSelectedIndex!].emoji == _cards[secondIndex].emoji) {
            _cards[_firstSelectedIndex!].isMatched = true;
            _cards[secondIndex].isMatched = true;
          } else {
            _cards[_firstSelectedIndex!].isFaceUp = false;
            _cards[secondIndex].isFaceUp = false;
          }
          _firstSelectedIndex = null;
          _waiting = false;
        });
      });
    }
  }

  void _resetGame() {
    setState(() {
      _firstSelectedIndex = null;
      _waiting = false;
      _initializeCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1), // light pastel yellow
      appBar: AppBar(
        title: Text("Memory Boost Game"),
        backgroundColor: Colors.orange.shade300,
        elevation: 2,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "🍊 Match the fruit pairs!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final card = _cards[index];
                return GestureDetector(
                  onTap: () => _onCardTap(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: card.isMatched
                          ? Colors.greenAccent.shade100
                          : card.isFaceUp
                              ? Colors.orange.shade100
                              : Colors.orange.shade300,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.shade200,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        card.isFaceUp || card.isMatched ? card.emoji : "❓",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: _resetGame,
            icon: Icon(Icons.refresh),
            label: Text("Restart"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade400,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CardModel {
  final String emoji;
  bool isFaceUp;
  bool isMatched;

  _CardModel({
    required this.emoji,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}
