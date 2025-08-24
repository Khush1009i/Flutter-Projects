import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(),
    );
  }
}

class AnimatedSplashScreen extends StatefulWidget {
  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _offsetAnimations;
  late List<Animation<double>> _fadeAnimations;
  final String _name = "Khush Soni";
  final int _letterCount = 10; // "Khush Soni" has 10 characters (including space)

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_letterCount, (index) => AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800 + (index * 200)),
    ));

    _offsetAnimations = List.generate(_letterCount, (index) {
      return Tween<Offset>(
        begin: Offset(index.isEven ? -2.0 : 2.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeOutBack,
      ));
    });

    _fadeAnimations = List.generate(_letterCount, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controllers[index],
          curve: Curves.easeIn,
        ),
      );
    });

    // Start animations sequentially
    for (int i = 0; i < _letterCount; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black87,
              Color(0xFF1a1a2e),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_letterCount, (index) {
              return SlideTransition(
                position: _offsetAnimations[index],
                child: FadeTransition(
                  opacity: _fadeAnimations[index],
                  child: Text(
                    _name[index],
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: index % 2 == 0 ? Colors.cyanAccent : Colors.redAccent,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: index % 2 == 0 ? Colors.cyanAccent : Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
