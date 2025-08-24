import 'package:flutter/material.dart';
import 'calculator_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _plusAnimation;
  late Animation<double> _minusAnimation;
  late Animation<double> _multiplyAnimation;
  late Animation<double> _divideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Animations for each symbol coming from different directions
    _plusAnimation = Tween<double>(begin: -150, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _minusAnimation = Tween<double>(begin: -150, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _multiplyAnimation = Tween<double>(begin: 150, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _divideAnimation = Tween<double>(begin: 150, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Rotation and fade animations
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
    _navigateToCalculator();
  }

  _navigateToCalculator() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CalculatorScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2B2B), // Matte dark charcoal background
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Plus symbol coming from top-right (Bronze)
                Transform.translate(
                  offset: Offset(_plusAnimation.value, -_plusAnimation.value),
                  child: Opacity(
                    opacity: _controller.value > 0.9 ? 0 : 1,
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFFCD7F32).withOpacity(0.9), // Bronze
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ),

                // Minus symbol coming from top-left (Brass)
                Transform.translate(
                  offset: Offset(
                    -_minusAnimation.value,
                    -_minusAnimation.value,
                  ),
                  child: Opacity(
                    opacity: _controller.value > 0.9 ? 0 : 1,
                    child: Text(
                      '−',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFFB5A642).withOpacity(0.9), // Brass
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ),

                // Multiply symbol coming from bottom-left (Copper)
                Transform.translate(
                  offset: Offset(
                    -_multiplyAnimation.value,
                    _multiplyAnimation.value,
                  ),
                  child: Opacity(
                    opacity: _controller.value > 0.9 ? 0 : 1,
                    child: Text(
                      '×',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFFB87333).withOpacity(0.9), // Copper
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ),

                // Divide symbol coming from bottom-right (Silver)
                Transform.translate(
                  offset: Offset(
                    _divideAnimation.value,
                    _divideAnimation.value,
                  ),
                  child: Opacity(
                    opacity: _controller.value > 0.9 ? 0 : 1,
                    child: Text(
                      '÷',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFFC0C0C0).withOpacity(0.9), // Silver
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ),

                // Final calculator icon with matte gold finish
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.rotate(
                    angle:
                        _rotationAnimation.value * 6.28, // Rotate 360 degrees
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            Color(0xFFD4AF37), // Gold
                            Color(0xFFBF953F), // Old gold
                            Color(0xFFFCF6BA), // Light gold
                            Color(0xFFB38728), // Dark gold
                          ],
                          stops: [0.0, 0.3, 0.7, 1.0],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.calculate,
                        size: 90,
                        color: Colors
                            .white, // This will be overridden by the shader
                      ),
                    ),
                  ),
                ),

                // App title with elegant typography
                Positioned(
                  bottom: 120,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Text(
                      'Calculator',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFD4AF37), // Gold
                        letterSpacing: 4,
                        fontFamily: 'Georgia',
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            // offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Elegant subtitle
                Positioned(
                  bottom: 80,
                  child: Opacity(
                    opacity: _fadeAnimation.value * 0.8,
                    child: Text(
                      'Calculator',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC0C0C0), // Silver
                        letterSpacing: 2,
                        fontStyle: FontStyle.normal,
                        // fontFamily: 'Georgia',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
