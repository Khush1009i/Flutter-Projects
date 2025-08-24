import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_service.dart';
import 'theme_provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorService _calculatorService = CalculatorService();
  String _currentInput = '';
  String _result = '0';
  String _operand1 = '';
  String _operand2 = '';
  String _operator = '';
  bool _isNewInput = true;
  bool _isError = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clearAll();
      } else if (buttonText == '⌫') {
        _backspace();
      } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
        _handleOperator(buttonText);
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == '.') {
        _addDecimal();
      } else if (buttonText == '%') {
        _handlePercentage();
      } else {
        _addDigit(buttonText);
      }
    });
  }

  void _clearAll() {
    _currentInput = '';
    _result = '0';
    _operand1 = '';
    _operand2 = '';
    _operator = '';
    _isNewInput = true;
    _isError = false;
  }

  void _backspace() {
    if (_currentInput.isNotEmpty) {
      if (_currentInput.endsWith(' ') && _currentInput.length >= 2) {
        // Remove the operator and trailing space
        _currentInput = _currentInput.substring(0, _currentInput.length - 2);
        _operator = '';
        _operand2 = '';
        _operand1 = _currentInput;
      } else {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
        // Clear operator and operand2 if we've backspaced past the operator
        if (!_currentInput.contains(' ')) {
          _operator = '';
          _operand2 = '';
          _operand1 = _currentInput;
        }
      }
      _result = _currentInput.isEmpty ? '0' : _currentInput;
    }
  }

  void _handleOperator(String newOperator) {
    if (_currentInput.isEmpty && _operand1.isEmpty) return;

    if (_operand1.isEmpty) {
      _operand1 = _currentInput.isEmpty ? _result : _currentInput;
      _operator = newOperator;
      _currentInput = '$_operand1 $newOperator ';
    } else {
      // Extract operand2 only if valid
      if (_currentInput.length > _operand1.length + 2) {
        _operand2 = _currentInput.substring(_operand1.length + 2).trim();
      }
      if (_operand2.isNotEmpty) {
        _calculateResult();
        _operand1 = _result;
        _operator = newOperator;
        _currentInput = '$_operand1 $newOperator ';
        _operand2 = '';
      } else {
        // Update operator if no second operand yet
        _operator = newOperator;
        _currentInput = '$_operand1 $newOperator ';
      }
    }
    _isNewInput = true;
  }

  void _calculateResult() {
    try {
      if (_operand1.isEmpty || _operator.isEmpty) return;
      // Extract operand2 only if valid
      if (_currentInput.length > _operand1.length + 2) {
        _operand2 = _currentInput.substring(_operand1.length + 2).trim();
      }
      if (_operand2.isEmpty) {
        _operand2 = _operand1; // For cases like "5 + ="
      }

      final expression = '$_operand1 $_operator $_operand2';
      final result = _calculatorService.calculate(expression);
      _result = result.toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), '');
      _currentInput = _result;
      _isError = false;
      _resetAfterCalculation();
    } catch (e) {
      _result = 'Error';
      _currentInput = _result;
      _isError = true;
      _resetAfterCalculation();
    }
  }

  void _handlePercentage() {
    try {
      if (_currentInput.isNotEmpty && _operand1.isEmpty) {
        final value = double.parse(_currentInput) / 100;
        _currentInput = value.toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), '');
        _result = _currentInput;
      } else if (_operand1.isNotEmpty) {
        if (_currentInput.length > _operand1.length + 2) {
          _operand2 = _currentInput.substring(_operand1.length + 2).trim();
        }
        if (_operand2.isNotEmpty) {
          final expression = '$_operand1 $_operator $_operand2 %';
          final result = _calculatorService.calculate(expression);
          _result = result.toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), '');
          _currentInput = _result;
          _isError = false;
          _resetAfterCalculation();
        }
      }
    } catch (e) {
      _result = 'Error';
      _currentInput = _result;
      _isError = true;
    }
  }

  void _addDecimal() {
    if (_isError) return;
    if (_operator.isEmpty) {
      if (!_currentInput.contains('.')) {
        _currentInput += _currentInput.isEmpty ? '0.' : '.';
      }
    } else {
      final secondPart = _currentInput.length > _operand1.length + 2
          ? _currentInput.substring(_operand1.length + 2).trim()
          : '';
      if (!secondPart.contains('.')) {
        _currentInput += secondPart.isEmpty ? '0.' : '.';
      }
    }
    _result = _currentInput.isEmpty ? '0' : _currentInput;
  }

  void _addDigit(String digit) {
    if (_isError) return;
    if (_isNewInput && _operator.isEmpty) {
      _currentInput = digit;
      _isNewInput = false;
    } else {
      _currentInput += digit;
    }
    _result = _currentInput;
  }

  void _resetAfterCalculation() {
    _operand1 = _result;
    _operand2 = '';
    _operator = '';
    _isNewInput = true;
  }

  Widget _buildButton(
    String text, {
    Color? bgColor,
    Color? textColor,
    double? fontSize,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.black12, width: 1),
            ),
            elevation: 4,
            shadowColor: Colors.black26,
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colors for number buttons
    final numberButtonColor = isDark
        ? const Color(0xFF3A3636)
        : const Color(0xFFF8F9FA);
    final numberTextColor = isDark ? Colors.white : const Color(0xFF2D2B2B);

    // Display box background color
    final displayBgColor = isDark ? const Color(0xFF2D2B2B) : const Color(0xFFFFFFFF);

    // Input text color inside display box
    final displayInputTextColor = isDark ? Colors.white : Colors.black;

    // Result text color
    final resultTextColor = _isError
        ? const Color(0xFFFF6B6B)
        : (isDark ? const Color.fromRGBO(212, 175, 55, 1) : const Color(0xFF4ECDC4));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with theme toggle
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(212, 175, 55, 1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'CALCULATOR',
                      style: theme.appBarTheme.titleTextStyle,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: theme.appBarTheme.foregroundColor,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Display area
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: displayBgColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Current Input Text
                  Text(
                    _currentInput.isEmpty ? '0' : _currentInput,
                    style: theme.textTheme.displayMedium!.copyWith(
                      color: displayInputTextColor,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Result Text
                  Text(
                    _result,
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: resultTextColor,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Buttons area
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        _buildButton(
                          'C',
                          bgColor: const Color(0xFFFF6B6B),
                          textColor: Colors.white,
                          fontSize: 20,
                        ),
                        _buildButton(
                          '⌫',
                          bgColor: const Color(0xFFFFA726),
                          textColor: Colors.white,
                          fontSize: 20,
                        ),
                        _buildButton(
                          '%',
                          bgColor: const Color(0xFF4ECDC4),
                          textColor: Colors.white,
                          fontSize: 20,
                        ),
                        _buildButton(
                          '/',
                          bgColor: const Color(0xFF45B7D1),
                          textColor: Colors.white,
                          fontSize: 24,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton(
                          '7',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '8',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '9',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          'x',
                          bgColor: const Color(0xFF45B7D1),
                          textColor: Colors.white,
                          fontSize: 24,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton(
                          '4',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '5',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '6',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '-',
                          bgColor: const Color(0xFF45B7D1),
                          textColor: Colors.white,
                          fontSize: 28,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton(
                          '1',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '2',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '3',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '+',
                          bgColor: const Color(0xFF45B7D1),
                          textColor: Colors.white,
                          fontSize: 24,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton(
                          '0',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '.',
                          bgColor: numberButtonColor,
                          textColor: numberTextColor,
                        ),
                        _buildButton(
                          '=',
                          bgColor: const Color(0xFF4CAF50),
                          textColor: Colors.white,
                          fontSize: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}