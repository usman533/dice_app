import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatefulWidget {
  const DiceApp({super.key});

  @override
  DiceAppState createState() => DiceAppState();
}

class DiceAppState extends State<DiceApp> {
  int currentPlayer = 1;
  List<int> diceValues = [1, 1, 1, 1];
  List<int> lastDiceValues = [0, 0, 0, 0];
  Random random = Random();

  void rollDice() {
    setState(() {
      int rolledValue = random.nextInt(6) + 1;
      diceValues[currentPlayer - 1] = rolledValue;

      if (rolledValue == 6) {
        if (lastDiceValues[currentPlayer - 1] == 6) {
          debugPrint('Player $currentPlayer rolled a second six. Next player\'s turn!');
          nextPlayer();
        } else {
          debugPrint('Player $currentPlayer rolled a six and gets an extra turn!');
        }
      } else {
        debugPrint('Player $currentPlayer did not roll a six. Moving to the next player.');
        nextPlayer();
      }
      lastDiceValues[currentPlayer - 1] = rolledValue;
    });
  }

  void nextPlayer() {
    setState(() {
      currentPlayer = (currentPlayer % 4) + 1; // Move to next player (1, 2, 3, 4)
      debugPrint('It\'s now Player $currentPlayer\'s turn.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ludo Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Player $currentPlayer\'s Turn',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Image.asset(
                  'images/d${diceValues[currentPlayer - 1]}.png',
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not found');
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: rollDice,
                child: const Text('Roll Dice'),
              ),
              const SizedBox(height: 20),
              Text(
                'Player 1: ${diceValues[0]}, Player 2: ${diceValues[1]}, '
                    'Player 3: ${diceValues[2]}, Player 4: ${diceValues[3]}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




