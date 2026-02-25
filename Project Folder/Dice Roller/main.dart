import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';
// runApp();
// Running ("Calling ) the funxn
// provide by the flutter itself.
// Arguments  :
// No parameters: void main(){...}
// parameter 1  : void main(text){...}
// parameter 2  : void(a, b ){...}

// Widget tree : combination of widgets, nested to each other
//    material app (root app taht require most widget)
//    scaffold     (screen layout widget add base styling & more)
//      row        (widget displays multiple adjacent child widget)
// Text Text  Text

//  runApp(MaterialApp()); //Create a widget run by using" runApp();

//run app needa widget to run itself.
//const keyword provided by dart to optimize the performance.
//const are indeed equal & avoid duplicate of work & load.

// Text("Hello, World!")

// value type:
// 1. int           : int, num, object
// 2. String        : String, object
// 3. Material App  : materialApp, widget, object

//defining a function

// MaterialApp() core widget of flutter

// Widget == objects == Data structures in memory.

void main() {
  // Defining a funxn
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromRGBO(47, 81, 255, 1),
          Color.fromARGB(255, 255, 152, 56),
        ),
      ),
    ),
  );
}
