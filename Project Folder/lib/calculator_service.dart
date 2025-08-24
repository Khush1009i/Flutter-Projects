class CalculatorService {
  double calculate(String expression) {
    try {
      // Replace 'x' with '*' for multiplication
      expression = expression.replaceAll('x', '*');
      // Split the expression into parts
      final parts = expression.split(' ');
      if (parts.length != 3) throw Exception('Invalid expression');

      final num1 = double.parse(parts[0]);
      final operator = parts[1];
      final num2 = double.parse(parts[2]);

      switch (operator) {
        case '+':
          return num1 + num2;
        case '-':
          return num1 - num2;
        case '*':
          return num1 * num2;
        case '/':
          if (num2 == 0) throw Exception('Division by zero');
          return num1 / num2;
        case '%':
          return (num1 * num2) / 100;
        default:
          throw Exception('Invalid operator');
      }
    } catch (e) {
      throw Exception('Calculation error: $e');
    }
  }
}