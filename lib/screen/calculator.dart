import 'package:calculator_app/components/number_button.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  late String _evaluation = "0";
  final List<String> _charsSpecials = ['+', '-', '/', '*'];
  final List<List<String>> numbers = const [
    ['7', '8', '9', '-'],
    ['4', '5', '6', '+'],
    ['1', '2', '3', '/'],
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _displayValue(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _inputKeyboard(),
            ),
          )
        ],
      ),
    );
  }

  Container _displayValue() {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.black,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _evaluation,
        style: const TextStyle(color: Colors.white, fontSize: 64),
      ),
    );
  }

  Table _inputKeyboard() {
    return Table(
      children: [
        for (var row in numbers)
          TableRow(children: [
            for (String column in row)
              NumberButton(
                number: column,
                buttonAction: (value) =>
                    setState(() => _updatedEvaluation(value)),
              ),
          ]),
        TableRow(children: [
          NumberButton(
            number: '0',
            buttonAction: (value) => _updatedEvaluation(value),
          ),
          NumberButton(
            number: 'C',
            buttonAction: (value) => _resetOperation(),
          ),
          NumberButton(
            number: '=',
            buttonAction: (value) => _generateResult(),
          ),
          NumberButton(
            number: '*',
            buttonAction: (value) => _updatedEvaluation(value),
          ),
        ]),
      ],
    );
  }

  void _updatedEvaluation(String value) {
    setState(() {
      final bool isNumber = !_charsSpecials.contains(value);
      if (_evaluation.startsWith('0') && isNumber) {
        _evaluation = _evaluation.substring(1);
      }
      bool currentValueIsSpecialChar = _charsSpecials.contains(value);
      if (_lastValueIsSpecialChar() && currentValueIsSpecialChar) {
        int sizeEval = _evaluation.length - 1;
        if (sizeEval == 0) return;
        _evaluation = _evaluation.substring(0, sizeEval);
      }

      _evaluation += value;
    });
  }

  void _resetOperation() {
    setState(() => _evaluation = "0");
  }

  void _generateResult() {
    setState(() {
      if (_lastValueIsSpecialChar()) {
        _evaluation = _evaluation.substring(0, _evaluation.length - 1);
      }

      const ExpressionEvaluator evaluator = ExpressionEvaluator();
      final Expression evalParser = Expression.parse(_evaluation);
      final String result = evaluator.eval(evalParser, {}).toString();
      _evaluation = result;
    });
  }

  bool _lastValueIsSpecialChar() {
    int sizeEval = _evaluation.length - 1;
    bool lastCharIsSpecialChar = false;
    if (sizeEval > 0) {
      lastCharIsSpecialChar =
          _charsSpecials.contains(_evaluation.substring(sizeEval));
    }
    return lastCharIsSpecialChar;
  }
}
