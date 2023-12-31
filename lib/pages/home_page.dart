import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index1 = 0, index2 = 0, point = 0;
  Random random = Random.secure();
  int sum = 0;
  bool hasGameStarted = false;
  bool isGameRunning = false;
  bool showDice = false;
  String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Game'),
      ),
      body: Center(
        child: hasGameStarted ? gameBody() : startBody(),
      ),
    );
  }

  Column startBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FlutterLogo(
          size: 100,
        ),
        const Text(
          'Welcome to Dice Game',
          style: TextStyle(fontSize: 25),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              hasGameStarted = true;
              isGameRunning = true;
            });
          },
          child: const Text('START'),
        )
      ],
    );
  }

  Column gameBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (showDice)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                diceList[index1],
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                diceList[index2],
                height: 100,
                width: 100,
              ),
            ],
          ),
        Text(
          'Dice Sum: $sum',
          style: const TextStyle(fontSize: 20),
        ),
        if (point > 0)
          Text(
            'Your Point: $point',
            style: const TextStyle(fontSize: 25),
          ),
        if (status != null)
          Text(
            'You $status',
            style: const TextStyle(fontSize: 25),
          ),
        if (isGameRunning)
          ElevatedButton(onPressed: rollTheDice, child: Text('Roll')),
        if (!isGameRunning)
          ElevatedButton(onPressed: _reset, child: Text('RESET')),
      ],
    );
  }

  void rollTheDice() {
    setState(() {
      if (!showDice) {
        showDice = true;
      }
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      sum = index1 + index2 + 2;
      _checkResult();
    });
  }

  void _reset() {
    setState(() {
      index1 = 0;
      index2 = 0;
      sum = 0;
      point = 0;
      hasGameStarted = false;
      status = null;
    });
  }

  void _checkResult() {
    if (point == 0) {
      if (sum == 7 || sum == 11) {
        status = 'Won';
        //isGameRunning = false;
      } else if (sum == 2 || sum == 3 || sum == 12) {
        status = 'Lost';
        //isGameRunning = false;
      } else {
        point = sum;
      }
    } else {
      if (sum == point) {
        status = 'Won';
        //isGameRunning = false;
      } else if (sum == 7) {
        status = 'Lost';
        //isGameRunning = false;
      }
    }
    if (status != null) isGameRunning = false;
  }
}

final diceList = [
  'assets/d1.PNG',
  'assets/d2.PNG',
  'assets/d3.PNG',
  'assets/d4.PNG',
  'assets/d5.PNG',
  'assets/d6.PNG',
];
