import 'dart:math'; // dart itself package

import 'package:flutter/material.dart';
// import 'package:first_app/gradient_container.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-1.png';

  void rollDice() {
    var diceRoll = Random().nextInt(6) +1;
    setState(() {
      activeDiceImage = 'assets/images/dice-$diceRoll.png';
      ('Changing image...'); // prints in debug console
    }
    
    );

    
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
           width: 200
           ),

        SizedBox(height: 20),

        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(
            //   top:20
            // ),
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            textStyle: TextStyle(fontSize: 30),
          ),

          // (){
          //   //.. option one
          // },
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
