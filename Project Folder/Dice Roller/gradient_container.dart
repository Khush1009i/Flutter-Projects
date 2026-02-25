import 'package:flutter/material.dart';
// import 'package:first_app/style_text.dart';
import 'package:first_app/dice_roller.dart';

// it is recommended to use "final" keyword use here instead of var
// var startAlignment = Alignment.topLeft; //if we tell what alignment we want
// final keyword is used to define a constant value that cannot be changed.
// or we can use const keyword to define a constant value.
// Alignment? startAlignment; // ? as it allow to store null value in it.
// this effects " begin: startAlignment" as no null handle it

// old method or another method "GradientContainer({Key}):super(key: key);"

const startAlignment = Alignment.centerLeft;
const endAlignment = Alignment.topCenter;
// var startAlignment = Alignment.topLeft;
// var endAlignment = Alignment.topRight;

// Custom widget
class GradientContainer extends StatelessWidget {
  const  GradientContainer(this.color1, this.color2, {super.key});
  // Construction function

   const GradientContainer.purple()
    : color1 = const Color.fromARGB(255, 200, 119, 49),
      color2 = const Color.fromARGB(255, 0, 0, 255);

  // intitalization code
  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: startAlignment,
          end: endAlignment,
        ),
      ),

      child: Center(
        child: DiceRoller(),
        ),
    );

  }
}







































//  const GradientContainer( this.colors, {super.key,}); // Construction function
// // const GradientContainer(  {super.key, required this.colors}); 
// // Construction function

//   // intitalization code
//   final List<Color> colors;

//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: colors,
//           begin: startAlignment,
//           end: endAlignment,
//         ),
//       ),

//       child: const Center(child: StyleText('Khush Soni')),
//     );
//   }
// }
