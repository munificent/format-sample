import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});

  final double height;
  final int weight;

  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height * 12, 2) * 703;
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'Anyone who is overweight should try to avoid gaining additional weight. Additionally, if you are overweight with other risk factors (such as high LDL cholesterol, low HDL cholesterol, or high blood pressure), you should try to lose weight. Even a small weight loss (just 10% of your current weight) may help lower the risk of disease. Talk with your healthcare provider to determine appropriate ways to lose weight.';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight. Maintaining a healthy weight may reduce the risk of chronic diseases associated with overweight and obesity.';
    } else {
      return 'You have a lower than normal body weight. Talk with your healthcare provider to determine possible causes of underweight and if you need to gain weight.';
    }
  }
}
